# Committed design decisions

Append one entry per decision the user commits to. Cite the entry when a later increment depends on it. If a decision is reversed, keep the entry and add the reversal below it — the history is useful when the user asks "why is it like this?".

Format:

```
## {date} — {decision}
**Context.** {which increment, what was being decided}
**Chosen.** {what the user picked}
**Rejected.** {alternatives, and why not}
**Downstream.** {increments this constrains}
```

---

## 2026-08-20 — Mentoring protocol

**Context.** Setting up how the user and the assistant work together on the iP.
**Chosen.** Assistant mentors only: breaks weeks into checkpoints, drops hints escalating on request, warns on expensive-to-undo choices, keeps plans in `.claude/skills/ip-mentor/`. User writes all production code.
**Rejected.** Assistant implements increments — the user wants exposure to the technical detail, and heavy AI authorship is hard to square with the course reuse policy.
**Downstream.** All increments.

## 2026-08-27 — Level-7 save format

**Context.** `Level-7`, choosing how the task list is stored between runs.
**Chosen.** Plain text, one task per line, fields separated by `" | "`, in the order type letter, done flag (`1`/`0`), description, then `by`/`from`, then `to`. Path `data/saved.txt`, relative to the working folder. Rewritten in full whenever the list changes; read at start-up.
**Rejected.** JSON — Java has no JSON parser in the standard library, so it needs either a third-party library (forum approval, and no build tool yet to carry the dependency) or a hand-written parser, which is a bug source. No gain for the flat records this app stores.
**Downstream.** `Level-8` writes dates into fields 4 and 5, so their text form has to stay machine-readable. `A-MoreOOP` moves `save`, `load`, and `parseSavedTask` into `Storage`.
**Known limitation, accepted for now.** A description containing `|` shifts the fields on reload and corrupts the task, silently. The user is aware.

## 2026-08-27 — Level-7 failure policy

**Context.** `Level-7`, after an edge-case probe found three faults: a failed write still printed a success message, a corrupted line was read in part, and non-ASCII text was stored double-encoded.
**Chosen.** A failed write raises `TaskSaveException`; the command undoes its own change first, so the list on screen always matches the file, and the user is asked to retry. A save file with any line that does not match the format is deleted in full at start-up, and the user is told, with the offending line quoted. Field counts per type are exact and the done flag must be `0` or `1`.
**Rejected.** Skipping bad lines and loading the rest — a partly loaded agenda hides what is missing. Moving the bad file aside instead of deleting it — the user asked for a delete; the backup variant is one line away if they change their mind.
**Downstream.** `Level-8` adds date fields, so the exact field counts in `parseSavedTask` have to move with it. `A-MoreOOP` moves this whole group into `Storage`.
**Open.** The console/file charset mismatch is not fixed. It is a JVM configuration problem, best solved in `build.gradle` at `A-Gradle`.

<!-- Add new entries below. -->
