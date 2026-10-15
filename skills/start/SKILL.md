---
name: start
description: Start a session context-first: orient from status, ADRs and conventions, and optionally pick up a ticket.
argument-hint: "[ticket reference]"
disable-model-invocation: true
---

1. Orient by following [ORIENT.md](ORIENT.md).

2. Pick the focus.
   - A ticket reference was passed: that ticket.
   - The status file names one in-progress ticket: that ticket.
   - It names several: list them and ask which.
   - None: summarise what is in progress, blocked, and next, propose a focus, and stop.

3. Load the ticket. Fetch it the way `docs/agents/issue-tracker.md` describes (default: `gh issue view <n>`), with its comments.
   - Read every ADR under `ADRs to read`.
   - Skim the file under `Pattern to mirror` once, for shape. If it no longer exists, ask for a replacement.
   - Read each existing file the ticket will modify. Leave everything else unread until implementation raises a concrete question.

4. Report to the user:
   - **Objective**: one line.
   - **Acceptance criteria**: verbatim from the ticket.
   - **Constraints**: each ADR loaded and what it requires of this change.
   - **Pattern to mirror** and the files you expect to touch.
   - **Open questions** the docs did not answer.

   Then suggest the next skill: `/cfd:implement`.
