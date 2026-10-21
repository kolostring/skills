---
name: implement
description: Implement a ticket or spec context-first: orient, build test-first, stop for an ADR when a new decision comes up, review, and commit.
argument-hint: "[ticket reference or spec]"
disable-model-invocation: true
---

Paths in this skill are relative to its folder.

1. **Orient.** Running as a subagent: follow [SUBAGENT.md](SUBAGENT.md) instead of this file. Otherwise, if this session hasn't run `cfd:start` for this work, follow `../start/ORIENT.md` and load the ticket as step 3 of `../start/SKILL.md` describes.

2. **Build test-first.** Use the `tdd` skill (`../tdd/SKILL.md`) at the seams the ticket or spec agreed. Before the first edit, read the pre-commit hook (`.git/hooks/pre-commit`, or what `.pre-commit-config.yaml`, husky or lefthook configures) and note every check it runs. Run single test files as you go, and once at the end run exactly what the hook runs. With no hook, run the type checker and the full test suite. Done when every check passes; keep its output for the review.

3. **Stop for missing decisions.** Before writing code that adds a dependency, pattern, boundary or deliberate deviation that no ADR covers and that meets the `cfd:adr` threshold, stop and propose the ADR with `../adr/SKILL.md`. Resume once the user accepts it.

   A choice that fits the existing ADRs and conventions needs no stop, and neither does a look or tuning still waiting on its verdict: step 6 covers it.

4. **Stop for conflicts.** When the code and an ADR disagree, show the user the conflict and leave both as they are until the user decides which is wrong.

5. **Review.** Run the `cfd:code-review` skill on the work (not Claude Code's built-in `/code-review`) and fix what it finds. Paste the check results from step 2 into both reviewer prompts, so they review the diff and take the checks as run.

6. **Collect the human verdict.** When the acceptance criteria need human judgement (a look, a feel, a tuning), stop and tell the user what to check and how. Collect the verdict, then write the findings entry (the verdict and what it changed) where the project keeps findings (default `docs/findings/<topic>.md`), or as a ticket comment if it keeps none.
   - Each attempt is a findings entry, not an ADR. A rejection sends you back to step 2 with the ADRs untouched.
   - Once the verdict accepts the result, write its one ADR with `../adr/SKILL.md` if the decision meets the threshold.

7. **Commit** to the current branch, then suggest `/cfd:close`.

## Running several tickets

As the orchestrator, delegating tickets to subagents:

- Before the first ticket, commit any uncommitted baseline work, so each ticket's diff holds only its own changes.
- Branches and worktrees follow the repo's `CLAUDE.md` / `AGENTS.md`. By default, run tickets one at a time on the current branch, in dependency order: each subagent builds its ticket, then you run steps 5 to 7 and commit it before the next one starts.
- Run tickets in parallel worktrees only when the repo allows worktrees and the tickets touch disjoint files. Before merging each worktree branch, check its `git diff --stat` holds only that ticket's files, then merge in dependency order.
- Brief each subagent with the ticket reference and the path to [SUBAGENT.md](SUBAGENT.md), nothing more: project gotchas belong in the `## Subagent briefs` section of `docs/CONVENTIONS.md`, which it reads.
