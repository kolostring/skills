---
name: tickets
description: Context-first wrapper around Matt Pocock's to-tickets: each ticket names the ADRs to read and a file to mirror.
disable-model-invocation: true
---

1. Orient by following `../start/ORIENT.md` (paths in this skill are relative to its folder).

2. Read `to-tickets`' instructions at `../to-tickets/SKILL.md` and follow them, with these overrides:
   - **Exploring the codebase:** you already oriented. Explore code only to find prefactoring opportunities or a pattern file.
   - **Ticket body:** add two sections after the acceptance criteria, in both the issue and local templates:

     ```md
     ## ADRs to read
     - [<slug>](docs/adr/<file>.md): what it constrains here

     ## Pattern to mirror
     `<path>`: an existing file whose shape this ticket's code should follow
     ```

     `Pattern to mirror` is the one deliberate exception to `to-tickets`' rule against file paths: it replaces exploration when the ticket starts, and `cfd:start` checks it still exists. Write `None (no analog)` only when no file fits.
   - **Quiz step:** show both sections for each ticket, so the user can correct them before publishing.
   - **Missing decisions:** when a ticket depends on a decision that has no ADR, make writing that ADR (with `cfd:adr`) a blocking ticket of its own.
