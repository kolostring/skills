# Upstream

## Matt Pocock's skills

- Source: https://github.com/mattpocock/skills (MIT, see `LICENSES/mattpocock-skills.txt`)
- Version: 1.3.2
- Commit: abeeaf95660ba9e8b7c753eb38f441ca707a8823
- Synced: 2026-11-20

The folders listed in `scripts/matt-skills.txt` are generated. Never edit them by hand: run `scripts/sync-matt.sh [ref]`, which re-copies them and reapplies these patches:

1. References to `/to-spec`, `/to-tickets`, `/setup-matt-pocock-skills`, `/grill-with-docs` and `/implement` point at `/cfd:spec`, `/cfd:tickets`, `/cfd:init`, `/cfd:grill` and `/cfd:implement`, and references to `/implement-spec` point at `/cfd:implement`.
2. References to `code-review` point at `cfd:code-review`, because Claude Code's built-in `/code-review` takes the short name.
3. `to-spec`, `to-tickets`, `setup-matt-pocock-skills`, `grilling`, `domain-modeling` and `codebase-design` are hidden from the `/` menu (`user-invocable: false`). The CFD wrappers and other skills read them directly. `grilling`'s description is replaced so the model picks `cfd:grill` for a user's request; it stays model-invocable because `triage` and `wayfinder` call it through the Skill tool.
4. `implement` and `prototype` are not vendored: the CFD skills of the same names replace them. The CFD `prototype` was seeded from upstream commit 24fe0ef7737efae15c87225755e9f6f5965e4888; diff its `LOGIC.md` and `UI.md` against upstream's to pick up later changes.
5. `implement-spec`, `ask-matt`, `to-questionnaire`, `wizard`, `grill-me`, `grill-with-docs` and `retro` are not vendored. `cfd:implement` orchestrates several tickets in place of `implement-spec`, `cfd:grill` covers `grill-me` and `grill-with-docs`, and `cfd:close` routes corrections in place of `retro`.

Any other change to a Matt skill belongs in a CFD skill (`init`, `start`, `close`, `grill`, `spec`, `tickets`, `implement`, `adr`, `report`, `prototype`, `telemetry-report`) or a new patch in the script.

## Context-First Development

- Source: https://github.com/albertomarturelo/context-first-development (MIT for code and templates, see `LICENSES/context-first-development.txt`)
- Telemetry version: 0.4.0
- Telemetry commit: e3840722c5e91f63b202020a7ca080e94f442099
- Telemetry synced: 2026-11-20

The CFD skills here are written for this plugin and follow CFD's principles: orient from status, ADRs and conventions; ADRs before code; corrections land in `docs/CONVENTIONS.md`. Upstream changes through the commit above were reviewed: releases after 0.2.0 changed no workflow rule.

Only `telemetry-report` is vendored, and only its `scripts/` and `references/` folders, which are generated: run `scripts/sync-cfd.sh [ref]`. Its `SKILL.md` is ours, because upstream's assumes the skill lives in `.agents/skills/`; the script prints upstream's URL to diff against. Patches:

1. `CONTEXT_PATHS` in `telemetry.py` lists this plugin's context files (`docs/adr`, `docs/agents`, `GLOSSARY.md`, `CODING_STANDARDS.md`) as well as upstream's.

`cfd-upgrade` is not ported: installs update with `/plugin update`.
