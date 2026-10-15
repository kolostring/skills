---
name: grill
description: Grill a plan context-first: orient from ADRs and conventions, interview the user until no decision is open, and record terms in GLOSSARY.md and decisions as ADRs.
argument-hint: "[plan or idea]"
disable-model-invocation: true
---

Paths in this skill are relative to its folder.

1. **Orient** by following `../start/ORIENT.md`. Note which parts of the plan existing ADRs and `docs/CONVENTIONS.md` already settle.

2. **Grill.** Read `../grilling/SKILL.md` and follow it, with these overrides:
   - A question an ADR or convention already answers is not asked. Name it as settled, with the ADR, in the round where it would have come up.
   - When the user's answer contradicts an accepted ADR, stop and ask whether to supersede it. Leave both as they are until the user decides.

3. **Terms.** Follow `../domain-modeling/SKILL.md` for `GLOSSARY.md` only: challenge fuzzy terms and record resolved ones as they happen. Its ADR guidance and `ADR-FORMAT.md` don't apply here.

4. **Decisions.** When the frontier is empty, list every settled decision that meets the `cfd:adr` threshold and has no ADR. Offer each one; write those the user accepts with `../adr/SKILL.md`.

5. **Finish.** Report the decisions settled (with their ADRs), the terms added, and anything left open. Suggest `/cfd:spec` next.
