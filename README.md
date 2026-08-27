## Acknowledgements

### AI-assisted code

Code in this repository that an AI tool generated is listed here, one entry per commit,
newest first. Each entry names the files and the methods involved. The same
information appears as a comment beside the code itself. Entries start with the
commits of 27 August 2026; earlier commits carry the code comments only.

#### Correct the Javadoc and cover every method

Claude (Anthropic), used through Claude Code, generated the code below on
28 August 2026, for A-JavaDoc. Nothing but comments changed.

* `src/main/java/gudgoi/GudGoi.java` — the corrected `@throws` and `{@link}` in
  `mark`, `unmark`, `deleteTask` and `handle`
* `src/main/java/gudgoi/task/Task.java` — the corrected references in
  `toSaveFormat` and `escape`
* `src/main/java/gudgoi/task/Todo.java`, `Deadline.java`, `Event.java` — header
  comments on the ten overriding methods

#### Add JUnit tests for parser, storage and task list

Claude (Anthropic), used through Claude Code, generated the code below on
28 August 2026, for A-JUnit. The cases come from edge cases I had already found
by running the program by hand.

* `src/test/java/gudgoi/ParserTest.java` — whole file
* `src/test/java/gudgoi/StorageTest.java` — whole file
* `src/test/java/gudgoi/TaskListTest.java` — whole file

#### Point Gradle at this project

Claude (Anthropic), used through Claude Code, generated the code below on
28 August 2026, for A-Gradle. The rest of `build.gradle` and the Gradle wrapper
came from the course repository and are not my work or Claude's.

* `build.gradle` — the two names that identify this project: `mainClass` and the
  name of the packaged JAR

#### Organize the classes into packages

Claude (Anthropic), used through Claude Code, generated the code below on
28 August 2026, for A-Packages. The change is mechanical: no method body was
altered.

* all 19 files under `src/main/java/gudgoi/` — the `package` declaration, and
  the `import` lines for the project classes each file now reaches across a
  package boundary
* `src/main/java/gudgoi/task/Task.java` — the change of `DISPLAY_FORMAT` from
  `protected` to `public`, and the comment explaining why

#### Turn GudGoi into an object with a constructor

Claude (Anthropic), used through Claude Code, generated the code below on
27 August 2026, for A-MoreOOP.

* `src/main/java/GudGoi.java` — the constructor, the change of `ui`, `storage`
  and `tasks` from static fields to instance fields, the move of the session
  into `run`, and the reduction of `main` to one line

#### Extract command reading into a Parser class

Claude (Anthropic), used through Claude Code, generated the code below on
27 August 2026, for A-MoreOOP. The method bodies inside `Parser` are my earlier
Level-4 to Level-8 code, moved; the class, the split of a line into a command
word and its arguments, and the header comments were generated.

* `src/main/java/Parser.java` — whole file
* `src/main/java/GudGoi.java` — the removal of `addTodo`, `addDeadline`,
  `addEvent`, `parseDateTime` and `parsePosition`, and the rewrite of `handle`
  to ask `Parser` for the command word, the arguments and the task

#### Extract the task list into a TaskList class

Claude (Anthropic), used through Claude Code, generated the code below on
27 August 2026, for A-MoreOOP. The bounds check inside `get` and `remove` is my
Level-5 code, moved from `taskAt`; the class, its constructors and the rest were
generated.

* `src/main/java/TaskList.java` — whole file
* `src/main/java/GudGoi.java` — the change of `tasks` to a `TaskList`, the split
  of `taskAt` into `parsePosition` plus the list's own bounds check, and the undo
  paths in `addAndConfirm`, `mark`, `unmark` and `deleteTask`

#### Extract file handling into a Storage class

Claude (Anthropic), used through Claude Code, generated the code below on
27 August 2026, for A-MoreOOP. The method bodies inside `Storage` are my earlier
Level-7 and Level-8 code, moved; the class, its constructor and the change from
printing to raising an Exception were generated.

* `src/main/java/Storage.java` — whole file
* `src/main/java/TaskLoadException.java` — whole file
* `src/main/java/GudGoi.java` — the `storage` field, and the change of the save
  and load call sites

#### Extract user interaction into a Ui class

Claude (Anthropic), used through Claude Code, generated the code below on
27 August 2026, for A-MoreOOP. The method bodies inside `Ui` are my earlier
code, moved unchanged; the class, its header comments and the call-site changes
were generated.

* `src/main/java/Ui.java` — whole file
* `src/main/java/GudGoi.java` — the `ui` field, the class header comment, and
  the change of every print and every read to go through `Ui`

#### Replace free-text times with real dates

Claude (Anthropic), used through Claude Code, generated the code below on
27 August 2026, from my specification of the Level-8 date handling: accept a
date on its own or a date with a time, store both as a date and time, default a
deadline to 00:00 and an event's end to 23:59, and reject an event that ends
before it starts.

* `src/main/java/GudGoi.java` — `INPUT_WITH_TIME`, `INPUT_DATE_ONLY`,
  `DEADLINE_DEFAULT_TIME`, `EVENT_END_DEFAULT_TIME`, `parseDateTime`, the date
  handling and the ordering check in `addDeadline` and `addEvent`, the ISO
  parsing in `parseSavedTask`, and the older-version line in
  `discardCorruptFile`
* `src/main/java/DateFormatException.java` — whole file
* `src/main/java/EventFormatException.java` — the constructor for an event that
  ends before it starts
* `src/main/java/Deadline.java` — the change of `by` to `LocalDateTime`, and the
  matching changes to the constructor, `getBy`, `toSaveFormat` and `toString`
* `src/main/java/Event.java` — the change of `from` and `to` to `LocalDateTime`,
  and the matching changes to the constructor, `getFrom`, `getTo`,
  `toSaveFormat` and `toString`
* `src/main/java/Task.java` — `DISPLAY_FORMAT`

#### Add saving and loading of the task list

Claude (Anthropic), used through Claude Code, generated the code below on
27 August 2026, from my specification of the Level-7 save format.

* `src/main/java/GudGoi.java` — `SAVE_PATH`, `save`, `parseSavedTask`,
  `unescape`, `load`, `discardCorruptFile`, and the undo-on-failure blocks in
  `addAndConfirm`, `mark`, `unmark` and `deleteTask`
* `src/main/java/TaskSaveException.java` — whole file
* `src/main/java/Task.java` — `getTypeLetter`, `toSaveFormat`, `escape`
* `src/main/java/Deadline.java` — `getTypeLetter`, `toSaveFormat`
* `src/main/java/Event.java` — `getTypeLetter`, `toSaveFormat`
* `src/main/java/Todo.java` — `getTypeLetter`

### Development-only tools — not part of the product

> **These are writing aids used while working on the project. None of them ship with the application.
> No code from them appears in `src/`, none is bundled in the released JAR, and no part of the product
> is derived from them. They affect documentation and notes only.**

* **Claude Code skills written for this project**, generated by Claude (Anthropic) at my direction
  and kept at `.claude/skills/`: `ip-mentor` (how the assistant and I split the work),
  `edge-case-probe` (a testing checklist), and `git-commit` (the checks to run before a commit,
  with two shell scripts that read the coding and commit standards). They are notes and checks for
  me, not part of the chatbot. No code from them reaches `src/`.

* **[asd-ste100-skill](https://github.com/danyuchn/asd-ste100-skill)** by Dustin Yuchen Teng, MIT License.
  A Claude Code skill that rewrites English into [ASD-STE100 Simplified Technical English](https://www.asd-ste100.org/),
  used to keep project documentation unambiguous.
  Kept at `.claude/skills/asd-ste100/`, at commit [`d5ce157`](https://github.com/danyuchn/asd-ste100-skill/commit/d5ce157870cf9c41efd1d6e836706a2be3c7b9da) (13 Aug 2026).
  The MIT licence text is retained in `.claude/skills/asd-ste100/LICENSE`.
