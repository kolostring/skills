---
name: close
description: Close a session context-first: update the status file, route corrections, and capture decisions as ADRs.
disable-model-invocation: true
---

Work through every step; the session is closed when all four completion conditions hold.

1. **Status.** Rewrite `.claude/STATUS.local.md` (create it, and add `.claude/STATUS.local.md` to `.gitignore` if missing). It is a snapshot for the next session, not a log: the tracker holds history. At most 40 lines:

   ```md
   # Status
   Last updated: YYYY-MM-DD

   ## In progress
   - <ticket ref>: <title>. <exact sub-state: what is done, what is next>

   ## Blocked
   - <ticket ref>: <blocker>

   ## Next
   1. <ticket ref or task>

   ## Notes
   - <gotcha or open question the next session needs>
   ```

   Done when the date is today and every ticket touched this session appears.

2. **Corrections.** List every time the user corrected a pattern this session. Route each one:
   - **Mechanical** (a banned API, an import shape, a file location): propose a lint rule, test, or check, and build it only on the user's yes.
   - **Judgement call:** add one line to `docs/CONVENTIONS.md`.

   Done when every correction has a destination.

3. **Decisions.** List decisions made in chat that meet the `cfd:adr` threshold and have no ADR. Offer each one; write those the user accepts with the `cfd:adr` skill.

   Done when every decision is written or declined by the user.

4. **Hand-off.** Propose a progress comment on each touched ticket. Tell the user which tracked doc changes (`docs/CONVENTIONS.md`, ADRs) belong in the same commit as this session's code. End with a one-paragraph summary suitable for a PR description.
