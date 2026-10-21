# skills

The team's agent plugin, `cfd`: context-first development on top of [Matt Pocock's skills](https://github.com/mattpocock/skills). It installs as a plugin in Claude Code and Codex, and as plain skills in any agent that reads `.agents/skills/`.

## Install

### Claude Code

On your machine, once:

```bash
claude plugin marketplace add <owner>/skills      # or a local path to this repo
claude plugin install cfd@skills
```

In each project, once, so teammates get it when they trust the folder:

```bash
claude plugin marketplace add <owner>/skills --scope project
claude plugin install cfd@skills --scope project
git add .claude/settings.json
```

Skills run as `/cfd:<name>`, for example `/cfd:init`.

### Codex

```bash
codex plugin marketplace add <owner>/skills
codex plugin add cfd@skills
```

Codex reads the same `.claude-plugin/` manifest and `hooks/hooks.json`. Pick skills from the skills list (`/skills`, or `$` and the skill name). If hooks are off in your Codex, run `start` yourself at the beginning of each session.

### Cursor, Copilot, Gemini CLI and others

```bash
npx skills@latest add <owner>/skills
```

This copies the skills into `.agents/skills/`, which these agents read. There's no session hook, so run `start` yourself. Update with `npx skills@latest update`.

### Then, in each repo

Run `init` once. It asks for the issue tracker, infers conventions from the repo's layout, and writes the docs below. Review every line marked `(inferred: confirm)`.

Don't install Matt's plugin or upstream CFD's plugin alongside this one: their skills are already in it, and upstream CFD's plugin is also named `cfd`.

## What it sets up in a repo

| File | Written by | Holds |
| --- | --- | --- |
| `docs/agents/*.md` | `/cfd:init` | Issue tracker, triage labels, domain doc layout |
| `CLAUDE.md` (`AGENTS.md` symlink) | `/cfd:init` | `## Agent skills` and `## Context-first` sections |
| `docs/adr/YYYY-MM-DD-<slug>.md` | `/cfd:adr` | One decision each, with rejected options |
| `docs/CONVENTIONS.md` | `/cfd:init`, `/cfd:close` | Rules learned from corrections |
| `CODING_STANDARDS.md` | `/cfd:init` | What `/cfd:code-review` checks |
| `GLOSSARY.md` | `/cfd:grill` | Domain terms |
| `.claude/STATUS.local.md` | `/cfd:close` | Snapshot for the next session; gitignored |

At every session start in a set-up repo, a hook loads the status snapshot and the ADR list, and warns when the status is older than the last commit. In a git repo that isn't set up, it suggests `/cfd:init`.

## Workflow

1. `/cfd:start [ticket]`: orient from status, ADRs and conventions; load the ticket.
2. `/cfd:grill`: settle open decisions; terms land in `GLOSSARY.md`, decisions in ADRs (`/cfd:adr`).
3. `/cfd:spec`, then `/cfd:tickets`: each ticket lists the ADRs to read and a file to mirror.
4. Per ticket, in a fresh session: `/cfd:start <ticket>`, then `/cfd:implement`. It builds test-first and stops to propose an ADR when a new decision comes up.
5. `/cfd:code-review` in a fresh session, then `/cfd:pr`.
6. `/cfd:close`: status, corrections, decisions.
7. `/cfd:report`: one short list of the session's work, for your timesheet.

## Skills

| Source | Skills |
| --- | --- |
| CFD (this repo) | `init`, `start`, `close`, `grill`, `spec`, `tickets`, `implement`, `adr`, `report`, `prototype` |
| Matt Pocock, vendored | everything listed in `scripts/matt-skills.txt` |

`init`, `grill`, `spec` and `tickets` wrap Matt's `setup-matt-pocock-skills`, `grill-with-docs`, `to-spec` and `to-tickets`, which are hidden from the `/` menu so each job has one entry point. `implement` and `prototype` replace Matt's skills of the same names.

Use `/cfd:code-review` and `/cfd:init` in full: Claude Code's built-in `/code-review` and `/init` take the short names.

## Maintaining

- **CFD skills** (`skills/{init,start,close,grill,spec,tickets,implement,adr,report,prototype}`): edit them directly.
- **Matt's skills**: never edit them. Run `scripts/sync-matt.sh <tag>` to update, review the diff, and commit. `UPSTREAM.md` records the version and the patches the script applies.
- **Release**: bump `version` in `.claude-plugin/plugin.json`. Claude Code and Codex install a new copy only when it changes. Run `claude plugin validate .` before pushing.
- **Portability**: skills refer to each other with paths relative to their own folder (`../to-spec/SKILL.md`), never `${CLAUDE_PLUGIN_ROOT}`, so they work in every agent.
