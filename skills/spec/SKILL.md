---
name: spec
description: Context-first wrapper around Matt Pocock's to-spec: orient from ADRs and conventions, then write the spec.
disable-model-invocation: true
---

1. Orient by following `../start/ORIENT.md` (paths in this skill are relative to its folder).

2. Read `to-spec`'s instructions at `../to-spec/SKILL.md` and follow them, with these overrides:
   - **Exploring the repo:** you already oriented. Explore code only for the open questions orientation left.
   - **Decisions:** when the spec settles a decision that meets the `cfd:adr` threshold, write that ADR with the `cfd:adr` skill before publishing the spec.
   - **Spec body:** add an `## ADRs` section listing the ADRs the implementation must respect, as links.
