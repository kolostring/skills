---
name: adr
description: ADR format and threshold for context-first repos; takes precedence over domain-modeling's ADR-FORMAT.md. Use when writing, editing or superseding an ADR, or deciding whether a decision needs one.
---

# ADRs

In a context-first repo, ADRs are what the agent orients from instead of reading code. Code is the truth about **what** the system does; ADRs are the truth about **why**. An ADR is only useful if it carries the why the code cannot: the rejected options.

This format replaces `domain-modeling`'s `ADR-FORMAT.md`. Everything else in `domain-modeling` (glossary, challenging terms) still applies.

## When a decision gets an ADR

Write one when the decision **constrains future code** and its reason cannot be recovered by reading the code:

- a new dependency, pattern, or strategy future code must follow
- a boundary or ownership rule ("billing references customers by ID only")
- a deliberate deviation from the obvious path
- a constraint invisible in the code (compliance, a partner contract, a latency budget)

It needs at least one real alternative that was rejected. A rule with no alternative is a convention: add it to `docs/CONVENTIONS.md` instead.

Write the ADR **before** the code that depends on it, then stop for the user to review it.

A look or tuning whose acceptance waits on a human verdict is still open: record each attempt as a findings entry where the project keeps findings (default `docs/findings/<topic>.md`). Once the verdict accepts the result, write one ADR for it, superseding any accepted ADR it changes (see "Changing a decision"). An ADR still `Proposed` may be amended in place instead.

## Location and name

- Use the existing ADR folder (`docs/adr/` or `docs/decisions/`); create `docs/adr/` if neither exists.
- Name new files `YYYY-MM-DD-<slug>.md` (today's date). The slug is the ADR's identity: short, specific, kebab-case. Check no existing file ends in `-<slug>.md` first.
- Existing numbered ADRs (`0007-*.md`) keep their names.
- There is no index file. List ADRs by running `adr-index.sh` from this skill's folder (use its absolute path; the shell runs in the repo).

## Template

At most 100 lines; one decision per ADR.

```md
# <Decision as a short noun phrase>

Status: Accepted | Proposed | Superseded by <slug>
Date: YYYY-MM-DD

## Context
The problem, the forces and constraints, and why it is being decided now.

## Decision
What we do. Concrete enough that a reviewer can check code against it.

## Considered options
- **<Option>**: rejected because <specific reason>.
- **<Option>**: rejected because <specific reason>.

## Consequences
What becomes easier, what becomes harder, what future code must do.
```

Status starts `Accepted` unless the user asks for `Proposed`. Consequences may be cut to one line when they are obvious.

## Changing a decision

An accepted ADR records what was decided; it is not edited into a different decision. To reverse one, write a new ADR and set the old one's status to `Superseded by <new-slug>`. Fixing typos, links, or a wrong fact is fine in place.

If the ADR changes a recurring convention, update `docs/CONVENTIONS.md` in the same change and cite the ADR there.
