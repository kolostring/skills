#!/usr/bin/env bash
# Vendor the telemetry-report scripts from Context-First Development
# (github.com/albertomarturelo/context-first-development) at a git ref and
# reapply this plugin's patches. Usage: scripts/sync-cfd.sh [ref]   (default: main)
#
# Only skills/telemetry-report/scripts/ and skills/telemetry-report/references/ are
# generated. skills/telemetry-report/SKILL.md is ours: upstream's assumes the skill
# lives in .agents/skills/. Diff it against upstream's after a sync.
#
# Patches (keep this list in sync with UPSTREAM.md):
#   1. CONTEXT_PATHS in telemetry.py lists this plugin's context files (docs/adr,
#      docs/agents, GLOSSARY.md, CODING_STANDARDS.md) instead of upstream's layout.
set -euo pipefail

ref=${1:-main}
root=$(cd "$(dirname "$0")/.." && pwd)
dest="$root/skills/telemetry-report"
up=templates/.agents/skills/telemetry-report

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
git clone -q https://github.com/albertomarturelo/context-first-development "$tmp/cfd"
git -C "$tmp/cfd" checkout -q "$ref"
sha=$(git -C "$tmp/cfd" rev-parse HEAD)
version=$(jq -r .version "$tmp/cfd/.claude-plugin/plugin.json")

rm -rf "$dest/scripts" "$dest/references"
mkdir -p "$dest"
cp -R "$tmp/cfd/$up/scripts" "$tmp/cfd/$up/references" "$dest/"
cp "$tmp/cfd/LICENSE" "$root/LICENSES/context-first-development.txt"

# Patch 1: count commits to this plugin's context files as context changes.
perl -0pi -e '
  s{^CONTEXT_PATHS = \[\n.*?\n\]\n}{CONTEXT_PATHS = [
    "CLAUDE.md", "AGENTS.md", "docs/adr", "docs/decisions", "docs/agents",
    "docs/CONVENTIONS.md", "CODING_STANDARDS.md", "GLOSSARY.md",
    ".claude/hooks", ".claude/settings.json",
]\n}sm or die "CONTEXT_PATHS not found in telemetry.py\n";
' "$dest/scripts/telemetry.py"

echo "Compare skills/telemetry-report/SKILL.md with upstream's:"
echo "  https://github.com/albertomarturelo/context-first-development/blob/$sha/$up/SKILL.md"

sed -i -E "s/^- Telemetry version: .*/- Telemetry version: $version/; s/^- Telemetry commit: .*/- Telemetry commit: $sha/; s/^- Telemetry synced: .*/- Telemetry synced: $(date +%F)/" "$root/UPSTREAM.md"
echo "Vendored telemetry-report from context-first-development $version ($sha)"
