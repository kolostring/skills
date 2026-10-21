# Engine Prototype

A variant of a look built **beside the real thing**, inside the engine, so the user can flip between them in the running app and judge which reads right. Use this when the question is about how something looks or feels in a game or native app: a material, a shader, an effect, a particle burst, a camera, a tuning. Screenshots and descriptions lose exactly what is being judged: motion, scale, lighting, the moment in play.

If the question is about logic, use [LOGIC.md](LOGIC.md); about a web page, [UI.md](UI.md).

## Process

### 1. State the question

Before building, write down what is being judged and what "right" means to the user: one or two sentences, in the findings entry you will finish in step 5. Read the topic's earlier findings entries first, so the variant doesn't repeat an attempt the user already rejected.

### 2. Build the variant beside the real thing

Keep the real version untouched and add the variant next to it:

- a duplicate node, material, resource or asset with a `_proto` suffix, in the same scene or folder as the original;
- a toggle the user flips from the editor: an exported flag or enum on the nearest script, or the visibility of the two siblings. Several variants get one enum, not several flags.

Only the variant's own files and the toggle change. Every other scene and asset stays as it is, so removing the prototype is a deletion, not an untangling.

### 3. Verify it reaches the output

Before asking for a verdict, confirm the variant actually changes what the app shows: the project compiles and its tests pass, the toggle switches what renders, a re-baked asset differs from the old one (compare the files or measure them). You cannot judge the look; the user does. Report which parameters differ between the variants, never how it looks.

### 4. Hand it over

Tell the user the exact path to the toggle (from the scene tree down to the property), which values select which variant, and where in the running app to look. They judge in play, whenever they get to it.

### 5. Capture the verdict and clean up

Write the findings entry as the [SKILL](SKILL.md) describes, with the verdict in the user's words. A rejection is a new variant (back to step 2), with the entry growing one attempt at a time. Once a variant wins, fold its parameters or assets into the real thing, then delete the `_proto` files and the toggle.

## Anti-patterns

- **Editing the real thing in place.** Without the original beside it, the user can't compare, and a rejected attempt has to be undone by hand.
- **Variants that differ in one small parameter.** That's tuning the real thing, not a prototype. Real variants disagree about approach.
- **Promoting the prototype directly.** Fold the winning values into the real asset or code and delete the `_proto` copies, so the scene doesn't carry dead siblings and toggles.
