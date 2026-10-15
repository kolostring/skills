#!/usr/bin/env bash
# Vendor Matt Pocock's skills (github.com/mattpocock/skills) at a git ref and
# reapply this plugin's patches. Usage: scripts/sync-matt.sh [ref]   (default: main)
#
# Patches (keep this list in sync with UPSTREAM.md):
#   1. References point at the CFD skills: /to-spec, /to-tickets, /setup-matt-pocock-skills,
#      /grill-with-docs and /implement become /cfd:spec, /cfd:tickets, /cfd:init, /cfd:grill
#      and /cfd:implement.
#   2. References to code-review become cfd:code-review, because Claude Code's built-in
#      /code-review takes the short name.
#   3. The wrapped skills get `user-invocable: false`, so each job has one entry point.
#      The CFD wrappers read their SKILL.md directly.
#   4. Replaced skills are not vendored: the CFD skill of the same name takes their place.
set -euo pipefail

ref=${1:-main}
root=$(cd "$(dirname "$0")/.." && pwd)
list="$root/scripts/matt-skills.txt"
own="start close init spec tickets adr report grill implement"
wrapped="to-spec to-tickets setup-matt-pocock-skills grill-with-docs"
replaced="implement"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
git clone -q https://github.com/mattpocock/skills "$tmp/mp"
git -C "$tmp/mp" checkout -q "$ref"
sha=$(git -C "$tmp/mp" rev-parse HEAD)
version=$(jq -r .version "$tmp/mp/.claude-plugin/plugin.json")

# Remove the previously vendored copies.
if [ -f "$list" ]; then
  while read -r name; do [ -n "$name" ] && rm -rf "${root:?}/skills/$name"; done < "$list"
fi
: > "$list"

# Copy every skill upstream ships in its plugin.
while read -r path; do
  name=$(basename "$path")
  case " $replaced " in *" $name "*) continue ;; esac
  for o in $own; do
    [ "$name" = "$o" ] && { echo "Upstream skill '$name' collides with a CFD skill" >&2; exit 1; }
  done
  cp -R "$tmp/mp/${path#./}" "$root/skills/$name"
  echo "$name" >> "$list"
done < <(jq -r '.skills[]' "$tmp/mp/.claude-plugin/plugin.json")
cp "$tmp/mp/LICENSE" "$root/LICENSES/mattpocock-skills.txt"

# Patches 1 and 2: point references at the CFD skills.
while read -r name; do
  find "$root/skills/$name" \( -name '*.md' -o -name '*.yaml' \) -exec perl -pi -e '
    s{(?<![\w./-])/to-spec(?![\w-])}{/cfd:spec}g;
    s{(?<![\w./-])/to-tickets(?![\w-])}{/cfd:tickets}g;
    s{(?<![\w./-])/setup-matt-pocock-skills(?![\w-])}{/cfd:init}g;
    s{(?<![\w./-])/grill-with-docs(?![\w-])}{/cfd:grill}g;
    s{(?<![\w./-])/implement(?![\w-])}{/cfd:implement}g;
    s{(?<![\w./-])/code-review(?![\w-])}{/cfd:code-review}g;
    s{`code-review`}{`cfd:code-review`}g;
  ' {} +
done < "$list"

# Patch 3: hide the wrapped skills from the / menu.
for name in $wrapped; do
  perl -0pi -e 's/\A---\n/---\nuser-invocable: false\n/' "$root/skills/$name/SKILL.md"
done

sed -i -E "s/^- Version: .*/- Version: $version/; s/^- Commit: .*/- Commit: $sha/; s/^- Synced: .*/- Synced: $(date +%F)/" "$root/UPSTREAM.md"
echo "Vendored mattpocock/skills $version ($sha): $(wc -l < "$list") skills"
