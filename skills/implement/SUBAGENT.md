# Implementing a ticket as a subagent

The orchestrator handed you a ticket and this file. Paths here are relative to this file's folder. You build the ticket and report; the orchestrator reviews, collects the human verdict and commits.

1. **Orient.** Run `../adr/adr-index.sh` with bash (absolute path; the shell runs in the repo) and read in full the ADRs whose titles touch the ticket. Read `docs/CONVENTIONS.md`, its `## Subagent briefs` section included, and `GLOSSARY.md` if it exists. Read `.claude/STATUS.local.md` only if it exists; a worktree has none.

2. **Load the ticket** the way `docs/agents/issue-tracker.md` describes, with its comments.
   - Read every ADR under `ADRs to read`.
   - Skim the file under `Pattern to mirror` once, for shape.
   - Read each existing file the ticket will modify.

3. **Build test-first** with the `tdd` skill (`../tdd/SKILL.md`) at the seams the ticket agreed. Before the first edit, read the pre-commit hook (`.git/hooks/pre-commit`, or what `.pre-commit-config.yaml`, husky or lefthook configures) and note every check it runs. Run single test files as you go, and once at the end run exactly what the hook runs. Done when every check passes.

4. **Report decisions and conflicts.** A dependency, pattern, boundary or deliberate deviation that no ADR covers and that meets the `cfd:adr` threshold (`../adr/SKILL.md`) is the user's to decide, as is any disagreement between the code and an ADR. Stop at it and report the decision or conflict, its options and your recommendation. Choices that fit the existing ADRs and conventions are yours to make.

5. **Stop before review**, with the work uncommitted. Report:
   - every file touched;
   - each check you ran and its result;
   - what is left for the human: a look or tuning to judge (what to check, and where), open decisions, conflicts.
