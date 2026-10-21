---
name: prototype
description: Build a throwaway prototype to answer a design question. Use when the user wants to sanity-check whether a state model or logic feels right, explore what a UI should look like, or try a look in the engine before committing to it.
---

# Prototype

A prototype is **throwaway code that answers a question**. The question decides the shape.

## Pick a branch

Identify which question is being answered, using the user's prompt, the surrounding code, or by asking if the user is around:

- **"Does this logic / state model feel right?"** → [LOGIC.md](LOGIC.md). Build a single shareable HTML file (free-play buttons plus tabbed guided walkthroughs) that pushes the state machine through cases that are hard to reason about on paper, and that a non-developer can drive.
- **"What should this web UI look like?"** → [UI.md](UI.md). Generate several radically different UI variations on a single route, switchable via a URL search param and a floating bottom bar.
- **"How should this look in the engine?"** (a game, a 3D or native app: a material, an effect, a tuning) → [ENGINE.md](ENGINE.md). Build the variant beside the real thing in the scene, toggled from the editor, and the user judges it in the running app.

The branches produce very different artifacts, so getting this wrong wastes the whole prototype. If the question is genuinely ambiguous and the user isn't reachable, default to whichever branch better matches the surrounding code (a backend module → logic; a web page or component → UI; a scene, shader or asset → engine) and state the assumption at the top of the prototype.

## Rules for every branch

1. **Throwaway from day one, and clearly marked as such.** Locate the prototype code close to where it will actually be used (next to the module, page or scene it's prototyping for) so context is obvious, but name it so a casual reader can see it's a prototype, not production. Obey whatever routing or scene convention the project already uses; don't invent a new top-level structure.
2. **Trivial to run.** A web UI prototype starts from one command in the project's task runner: `pnpm <name>`, `python <path>`, `bun <path>`, etc. A logic demo is a single HTML file the user double-clicks. An engine prototype runs from the editor's usual play button. No thinking required to start it.
3. **No persistence by default.** State lives in memory. Persistence is the thing the prototype is _checking_, not something it should depend on. If the question explicitly involves a database, hit a scratch DB or a local file with a clear "PROTOTYPE, wipe me" name.
4. **Skip the polish.** No tests, no error handling beyond what makes the prototype _runnable_, no abstractions. The point is to learn something fast.
5. **Surface the state.** After every action (logic), on every variant switch (UI), or beside every toggle (engine), show the full relevant state or parameters so the user can see what changed.
6. **Uncommitted on the current branch.** The prototype lives in the working tree only. Commit real work beside it by staging only the real files.
7. **Findings first, then fold, then delete.** Once the user has judged it, write the findings entry where the project keeps findings (default `docs/findings/<topic>.md`; a ticket comment if it keeps none): the question, each variant tried, the user's verdict in their own words, why it worked or failed, and what is still open. Then fold only the validated result into the real code, and delete the prototype. The findings entry is what outlives the prototype, so it is written before anything is deleted.
