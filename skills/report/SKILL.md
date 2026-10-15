---
name: report
description: Summarize this session's work as one short bullet list for justifying work hours. Invoke explicitly at the end of a session or when asked for a work report.
argument-hint: "[extra scope, e.g. 'include yesterday's commits']"
disable-model-invocation: true
---

Write one bullet list of the work done in this session, for a timesheet. The reader is a manager, not an engineer: they need to see what got done and why it took time.

## Sources

- The conversation from its first message: what the user asked for, what was changed, what was investigated.
- If earlier parts of the session were compacted away, `git log` and `git diff --stat` for the commits and uncommitted changes made during the session.
- Anything the user adds as an argument.

## What goes in

- Changes made: features, fixes, refactors, configuration, tooling, documents written for people.
- Research: what was investigated and what it concluded, in one clause ("Compared X and Y; chose X for Z").
- Design and decision work, stated as the outcome ("Defined the plugin structure for the team's skills").
- Problems diagnosed, including dead ends that shaped the result.

## What stays out

- Reading documentation, code, or files.
- ADRs, `docs/CONVENTIONS.md`, status files and other context upkeep.
- Building, running, testing or validating that something works.
- Session rituals, tool calls, and the agent's own process.

## Shape

- One flat list, no headings, no preamble, no closing line.
- Group related work into one bullet: one bullet per outcome, not per step. Aim for 3 to 7 bullets; more only for a long session with unrelated work.
- Each bullet is one line, under about 20 words, starting with a past-tense verb (Built, Fixed, Researched, Migrated, Set up).
- Plain words a non-engineer understands. Name the product area, not file paths or function names.
- Order by effort, largest first.
- Never invent work or inflate it. Leave out anything you are unsure happened this session.

## Example

- Built a shared plugin that bundles the team's AI development workflow for Claude Code and Codex.
- Researched how skills and plugins are installed and shared across agents; chose a team-owned plugin.
- Merged two third-party skill sets into one, resolving conflicts in naming and decision records.
- Wrote setup and usage guides for new team members.
