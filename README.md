## Acknowledgements

### AI-assisted code

Code in `src/` that an AI tool generated is listed here, one entry per commit,
newest first. Each entry names the files and the methods involved. The same
information appears as a comment beside the code itself. Entries start with the
commits of 27 August 2026; earlier commits carry the code comments only.

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

* **[asd-ste100-skill](https://github.com/danyuchn/asd-ste100-skill)** by Dustin Yuchen Teng, MIT License.
  A Claude Code skill that rewrites English into [ASD-STE100 Simplified Technical English](https://www.asd-ste100.org/),
  used to keep project documentation unambiguous.
  Kept at `.claude/skills/asd-ste100/`, at commit [`d5ce157`](https://github.com/danyuchn/asd-ste100-skill/commit/d5ce157870cf9c41efd1d6e836706a2be3c7b9da) (13 Aug 2026).
  The MIT licence text is retained in `.claude/skills/asd-ste100/LICENSE`.
