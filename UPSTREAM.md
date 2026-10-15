# Upstream

## Matt Pocock's skills

- Source: https://github.com/mattpocock/skills (MIT, see `LICENSES/mattpocock-skills.txt`)
- Version: 1.3.1
- Commit: 24fe0ef7737efae15c87225755e9f6f5965e4888
- Synced: 2026-10-15

The folders listed in `scripts/matt-skills.txt` are generated. Never edit them by hand: run `scripts/sync-matt.sh [ref]`, which re-copies them and reapplies these patches:

1. References to `/to-spec`, `/to-tickets`, `/setup-matt-pocock-skills`, `/grill-with-docs` and `/implement` point at `/cfd:spec`, `/cfd:tickets`, `/cfd:init`, `/cfd:grill` and `/cfd:implement`.
2. References to `code-review` point at `cfd:code-review`, because Claude Code's built-in `/code-review` takes the short name.
3. `to-spec`, `to-tickets`, `setup-matt-pocock-skills` and `grill-with-docs` are hidden from the `/` menu (`user-invocable: false`). The CFD wrappers read them directly.
4. `implement` is not vendored: the CFD `implement` replaces it.

Any other change to a Matt skill belongs in a CFD skill (`init`, `start`, `close`, `grill`, `spec`, `tickets`, `implement`, `adr`, `report`) or a new patch in the script.

## Context-First Development

- Source: https://github.com/albertomarturelo/context-first-development (MIT)

Not vendored. The CFD skills here are written for this plugin and follow CFD's principles: orient from status, ADRs and conventions; ADRs before code; corrections land in `docs/CONVENTIONS.md`.
