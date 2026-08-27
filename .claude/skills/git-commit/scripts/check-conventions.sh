#!/usr/bin/env bash
# Reports possible breaches of the se-education Java coding standard (intermediate level).
# https://se-education.org/guides/conventions/java/intermediate.html
#
# Usage: bash check-conventions.sh File1.java File2.java ...
#
# The output is a list of suspects, not a verdict. Every line needs a human check,
# because the tests are text patterns, not a Java parser. Exit code 1 means that
# the script printed at least one suspect.

if [ "$#" -eq 0 ]; then
    echo "usage: $0 <java files>" >&2
    exit 2
fi

found=0
work="${TMPDIR:-/tmp}/check-conventions.$$"
trap 'rm -f "$work"' EXIT

# report <file> <"line:text" stream> <message>
report() {
    while IFS= read -r hit; do
        [ -z "$hit" ] && continue
        printf '%s:%s | %s\n' "$1" "${hit%%:*}" "$3"
        found=1
    done <<< "$2"
}

# Blanks every comment but keeps the line count, so that a line number stays true.
# The code checks run on this copy. A word such as "class" inside a comment then
# raises no false alarm.
strip_comments() {
    awk '
        {
            line = $0
            if (inblock) {
                if (line ~ /\*\//) { sub(/^.*\*\//, "", line); inblock = 0 } else { line = "" }
            }
            if (!inblock) {
                gsub(/\/\*([^*]|\*[^\/])*\*\//, "", line)   # whole block on one line
                if (line ~ /\/\*/) { sub(/\/\*.*$/, "", line); inblock = 1 }
                sub(/\/\/.*$/, "", line)                    # line comment, and trailing comment
            }
            print line
        }' "$1"
}

for f in "$@"; do
    [ -f "$f" ] || continue
    strip_comments "$f" > "$work"

    # Whitespace and length: run on the original file, comments included.
    report "$f" "$(grep -n -P '^\t' "$f")"           "tab indentation; use 4 spaces"
    report "$f" "$(grep -n -P '^.{121,}$' "$f")"     "line over 120 characters (hard limit)"
    report "$f" "$(grep -n -P '[ \t]+$' "$f")"       "trailing whitespace"

    # Code checks: run on the comment-free copy.
    report "$f" "$(grep -n -P '^\s*import .*\.\*;' "$work")" "wildcard import; list each class"
    report "$f" "$(grep -n -P '^\s*\{\s*$' "$work")"         "opening brace on its own line; put it on the previous line"
    report "$f" "$(grep -n -P '\b(if|for|while|switch|catch)\(' "$work")" "missing space after the keyword"
    report "$f" "$(grep -n -P '\b(int|long|short|byte|char|boolean|float|double|String|[A-Z]\w*)\s+\w+\s*\[\s*\]' "$work")" "C-style array; write int[] a"
    report "$f" "$(grep -n -P '^\s*public\s+(?!.*\b(class|interface|enum|record|static\s+final)\b)[\w<>\[\], .]+\s+\w+\s*(=|;)' "$work")" "public field; make it private and add an accessor"
    report "$f" "$(grep -n -P '\bstatic\s+final\b[\w<>\[\], .]*\s+(?![A-Z0-9_]+\s*[=;])\w+\s*[=;]' "$work")" "static final field with a lower-case name; rename it UPPER_CASE if it is a true constant"
    report "$f" "$(grep -n -P '^\s*((public|protected|private|abstract|final|static|sealed)\s+)*(class|interface|enum|record)\s+(?![A-Z])\w+' "$work")" "type name is not PascalCase"

    # Method declaration whose name does not start with a lower-case letter.
    # The second grep drops constructors, because a constructor repeats the type name.
    report "$f" "$(grep -n -P '^\s*(public|protected|private)\s+(?!.*\b(class|interface|enum|record)\b)[\w<>\[\], .]+\s+(?![a-z])\w+\s*\(' "$work" \
        | grep -v -P '^\d+:\s*(public|protected|private)\s+('"$(basename "$f" .java)"')\s*\(')" \
        "method name is not camelCase"

    # A line that continues the statement above it is indented 8 spaces further
    # than the line that started the statement. A statement ends at ; { } or :
    # so the next line starts a new one. Blank lines, comments and annotations
    # break the chain, because none of them continues a statement.
    report "$f" "$(awk '
        BEGIN { stmt = -1 }
        {
            s = $0
            sub(/^[ \t]*/, "", s)
            sub(/[ \t]*$/, "", s)
            if (s == "" || s ~ /^@/) { stmt = -1; next }
            indent = match($0, /[^ ]/) - 1
            # A line that only closes what an earlier line opened may sit at the
            # indent of the statement it closes. That is normal Java layout, so
            # it is not measured.
            closer = (s ~ /^[)}\]]/)
            if (stmt >= 0 && !closer && indent != stmt + 8) {
                printf "%d:%s\n", NR, s
            }
            last = substr(s, length(s), 1)
            if (last == ";" || last == "{" || last == "}" || last == ":") {
                stmt = -1
            } else if (stmt < 0) {
                stmt = indent
            }
        }' "$work")" "wrapped line: indent it 8 spaces past the line that starts the statement"

    # A public class or public method needs a header comment. The line above the
    # declaration must close a Javadoc block, or must carry an annotation such as
    # @Override. This check needs the comments, so it reads the original file.
    report "$f" "$(awk '
        {
            line = $0
            sub(/^[ \t]+/, "", line)
            if (line ~ /^public[ \t]/ && line !~ /^public[ \t]+(static[ \t]+)?final[ \t]/ && line ~ /[({]/) {
                if (prev !~ /\*\/$/ && prev !~ /^@/) {
                    printf "%d:%s\n", NR, line
                }
            }
            if (line != "") { prev = line }
        }' "$f")" "public class or method with no Javadoc above it"
done

if [ "$found" -eq 0 ]; then
    echo "No suspects found. Read the diff for the rules that a pattern cannot check."
fi
exit "$found"
