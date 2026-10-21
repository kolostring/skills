---
name: init
description: Set up a repo for context-first development on top of Matt Pocock's skills, inferring docs from structure without reading source.
disable-model-invocation: true
---

Bootstrap context-first docs in this repo. Infer from the **shape** of the repo: its directory tree, dependency files, README, and existing docs. Source files stay unread; refinement comes later through real work and `cfd:adr`.

## 1. Matt's setup

If `docs/agents/issue-tracker.md` is missing, read `setup-matt-pocock-skills`' instructions at `../setup-matt-pocock-skills/SKILL.md` (relative to this skill's folder) and follow them to completion first.

## 2. Explore

- `git ls-files | cut -d/ -f1-2 | sort -u` for the layout.
- Dependency files: `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `*.csproj`, `Gemfile`, and the like.
- `README*`, `CLAUDE.md`, `AGENTS.md`, `CONTRIBUTING.md`, `CODING_STANDARDS.md`, `docs/`.
- Existing ADR folder (`docs/adr/` or `docs/decisions/`) and existing `docs/CONVENTIONS.md`.

## 3. Draft and confirm

Draft each item below, skipping any that already exists (extend existing files rather than replacing them). Show the drafts to the user and apply their edits before writing.

1. **Initial architecture ADR**, in the `cfd:adr` format, at `<ADR folder>/<today>-initial-architecture.md`: the layers, modules and data flow the layout implies, and the stack with versions from the dependency files. Mark each inference `(inferred: confirm)`. Skip it when the repo already has ADRs.
2. **`docs/CONVENTIONS.md`**: 5 to 10 conventions the layout and dependency choices imply, each marked `(inferred: confirm)`, under the heading `# Conventions`. End it with two empty sections:

   ```md
   ## Process
   How agents work in this repo: rules from corrections about the workflow rather than the code.

   ## Subagent briefs
   Gotchas every implementer subagent needs: checks the hook runs that one command misses, shell quirks.
   ```
3. **`CODING_STANDARDS.md`** (or a new section in the existing standards file), read by the reviewer:

   ```md
   ## Decisions
   - Code that contradicts an ADR is a finding; cite the ADR. When the ADR is the stale side, the finding is "supersede the ADR".
   - A new dependency, pattern or strategy that meets the `cfd:adr` threshold and has no ADR is a finding.
   - Conventions live in `docs/CONVENTIONS.md`.
   ```
4. **`.gitignore`**: add `.claude/STATUS.local.md`.
5. **Context-first section** in the agent instructions file (`CLAUDE.md` if it exists, else `AGENTS.md`), below the `## Agent skills` block. Replace `<ADR folder>`:

   ```md
   ## Context-first

   - Orient from `.claude/STATUS.local.md`, the ADRs in `<ADR folder>` and `docs/CONVENTIONS.md`. Read code to answer a question they leave open, or to change a file.
   - Code is the truth about what the system does; ADRs are the truth about why. When they disagree, stop and flag it.
   - A decision that constrains future code gets an ADR (`cfd:adr` format) before the code. Mid-implementation, stop and propose the ADR before writing that code.
   - As a subagent, never make such a decision: stop and report it, with options and a recommendation, to the parent, which asks the user.
   - When corrected on a pattern, record the rule: a check if mechanical, `docs/CONVENTIONS.md` if a judgement call, its `## Process` section if it is about how the agent works.
   - Findings live in `docs/findings/<topic>.md`, one dated entry per attempt at a look or tuning: what was tried, the user's verdict in their words, what is still open.
   - Sessions: `/cfd:start` to begin, `/cfd:close` to end.
   ```
6. **Second agents file**: when only one of `CLAUDE.md` / `AGENTS.md` exists, create the other as a symlink to it (`ln -s CLAUDE.md AGENTS.md`), so every agent reads the same rules.
7. **`docs/agents/domain.md`**: append, so Matt's skills follow the same rules when called directly:

   ```md
   ## Context-first overrides

   - Before exploring code, read the ADRs touching the area and `docs/CONVENTIONS.md`; explore code only for what they leave open.
   - New ADRs are named `YYYY-MM-DD-<slug>.md` and follow the `cfd:adr` skill, which takes precedence over `domain-modeling`'s `ADR-FORMAT.md`.
   ```

## 4. Finish

Write the confirmed items. Report what was created or changed, and ask the user to review every `(inferred: confirm)` line before real work starts.
