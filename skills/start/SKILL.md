---
name: start
description: "Start a session context-first: orient from status, ADRs and conventions, pick a spec to implement or continue (or one ticket), and hand it to implement."
argument-hint: "[spec or ticket reference]"
disable-model-invocation: true
---

Paths in this skill are relative to its folder.

1. Orient by following [ORIENT.md](ORIENT.md).

2. **Pick the focus.**
   - A ticket reference was passed: that ticket alone. Go to step 4. If the reference could name more than one ticket or spec, ask which.
   - A spec reference was passed: that spec.
   - Otherwise, list the open specs the way `docs/agents/issue-tracker.md` describes (local tracker: every `.scratch/<feature-slug>/spec.md`). For each one, show:
     - its title and reference;
     - its tickets: how many are done, open and blocked;
     - what `.claude/STATUS.local.md` says about it under `In progress`, `Blocked` and `Next`.

     Put the specs the status file names as in progress first. Ask which spec to implement or continue, and stop until the user answers.

3. **Plan the spec's tickets.** Fetch the spec and its tickets with their comments.
   - No tickets yet: suggest `/cfd:tickets <spec>` and stop.
   - Otherwise, list the open tickets in dependency order. For each one, show its title, its blockers and the subagent model step 5 would brief it with (see "Running several tickets" in `../implement/SKILL.md`). Mark the ticket the status file names as in progress, with its sub-state, so it resumes first.

4. **Load the ticket**, for a single ticket. Fetch it the way `docs/agents/issue-tracker.md` describes (default: `gh issue view <n>`), with its comments.
   - Read every ADR under `ADRs to read`.
   - Skim the file under `Pattern to mirror` once, for shape. If it no longer exists, ask for a replacement.
   - Read each existing file the ticket will modify. Leave everything else unread until implementation raises a concrete question.

   Then report:
   - **Objective**: one line.
   - **Acceptance criteria**: verbatim from the ticket.
   - **Constraints**: each ADR loaded and what it requires of this change.
   - **Pattern to mirror** and the files you expect to touch.
   - **Open questions** the docs did not answer.

5. **Hand off.** Ask the user to confirm the plan from step 3 or step 4, then follow `../implement/SKILL.md`. For a spec, act as its orchestrator ("Running several tickets"). For a single ticket, build it yourself.
