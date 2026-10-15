#!/usr/bin/env bash
# SessionStart hook: stdout is added to the agent's context.
# - Repo set up for CFD: load the status snapshot and the ADR list, and warn when the status is stale.
# - Git repo not set up yet: suggest /cfd:init once.
# - Anything else: stay silent.
set -uo pipefail

cd "${CLAUDE_PROJECT_DIR:-$PWD}" 2>/dev/null || exit 0
root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
cd "$root" || exit 0

if [ ! -f docs/agents/issue-tracker.md ] && [ ! -f docs/CONVENTIONS.md ]; then
  echo "This repo is not set up for context-first development. If the user starts feature work, mention once that /cfd:init sets it up. Do not run it unprompted."
  exit 0
fi

status=.claude/STATUS.local.md
if [ -f "$status" ]; then
  echo "=== $status (loaded at session start) ==="
  cat "$status"
  echo
  status_time=$(stat -c %Y "$status" 2>/dev/null || stat -f %m "$status" 2>/dev/null || echo 0)
  commit_time=$(git log -1 --format=%ct 2>/dev/null || echo 0)
  if [ "$commit_time" -gt $(( status_time + 86400 )) ]; then
    echo "WARNING: the newest commit is more than a day newer than $status. Check its claims against git log before trusting them, and tell the user."
    echo
  fi
else
  echo "No $status yet: /cfd:close writes it at the end of a session."
  echo
fi

echo "=== ADRs (loaded at session start) ==="
bash "$(dirname "$0")/../skills/adr/adr-index.sh"
echo
echo "Start work with /cfd:start [ticket]; end it with /cfd:close."
exit 0
