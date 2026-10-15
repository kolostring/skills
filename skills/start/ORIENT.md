# Context-first orientation

Shared by `cfd:start`, `cfd:spec`, and `cfd:tickets`. Skip it when this session already oriented.

Orient from the docs, in this order:

1. **Status.** Read `.claude/STATUS.local.md` if it exists. Compare its modification time with the last commit (`stat -c %Y`, `git log -1 --format=%ct`); if the newest commit is more than a day newer, tell the user the status may be stale and check its claims against `git log`.
2. **Decisions.** Run `../adr/adr-index.sh` with bash, resolving the path against this file's folder (skip it when the session-start context already lists the ADRs). Read in full the ADRs whose titles touch the work at hand.
3. **Vocabulary.** Read `GLOSSARY.md` (or the relevant one under `GLOSSARY-MAP.md`) if it exists.
4. **Conventions.** Read `docs/CONVENTIONS.md` before the first edit of the session.

Orientation is done when you can name the ADRs that constrain the work and every open question the docs leave.

## Reading code afterwards

Read code for two reasons: to answer a specific open question the docs leave, or to change a file (read it fully before editing). Name the question before you search.

When docs and code disagree, code is the truth about **what** the system does, ADRs about **why**. Stop and show the user the conflict; leave both as they are until the user decides which one is wrong.
