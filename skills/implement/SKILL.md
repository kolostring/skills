---
name: implement
description: Implement a ticket or spec context-first: orient, build test-first, stop for an ADR when a new decision comes up, review, and commit.
argument-hint: "[ticket reference or spec]"
disable-model-invocation: true
---

Paths in this skill are relative to its folder.

1. **Orient.** If this session hasn't run `cfd:start` for this work, follow `../start/ORIENT.md` and load the ticket as step 3 of `../start/SKILL.md` describes.

2. **Build test-first.** Use the `tdd` skill (`../tdd/SKILL.md`) at the seams the ticket or spec agreed. Run the type checker and single test files as you go, and the full test suite once at the end.

3. **Stop for missing decisions.** Before writing code that adds a dependency, pattern, boundary or deliberate deviation that no ADR covers and that meets the `cfd:adr` threshold:
   - Stop and propose the ADR with `../adr/SKILL.md`. Resume once the user accepts it.
   - Running as a subagent: don't decide and don't write the ADR. Stop and report the decision, its options and your recommendation to the parent.

   A choice that fits the existing ADRs and conventions needs no stop.

4. **Stop for conflicts.** When the code and an ADR disagree, show the user the conflict and leave both as they are until the user decides which is wrong.

5. **Review.** Run the `cfd:code-review` skill on the work (not Claude Code's built-in `/code-review`) and fix what it finds.

6. **Commit** to the current branch, then suggest `/cfd:close`.
