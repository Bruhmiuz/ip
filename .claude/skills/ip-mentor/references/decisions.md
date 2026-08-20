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

<!-- Add new entries below. -->
