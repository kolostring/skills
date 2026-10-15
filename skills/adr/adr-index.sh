#!/usr/bin/env bash
# Print one line per ADR: <file> | <status> | <title>. No index file to maintain.
set -uo pipefail
root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
dir=""
for d in docs/adr docs/decisions; do [ -d "$root/$d" ] && { dir="$root/$d"; break; }; done
[ -n "$dir" ] || { echo "No ADR folder (docs/adr or docs/decisions)."; exit 0; }
echo "ADRs in ${dir#$root/}:"
for f in "$dir"/*.md; do
  [ -e "$f" ] || { echo "  (none)"; break; }
  name=$(basename "$f" .md)
  case "$name" in _*|TEMPLATE|template|README) continue ;; esac
  title=$(grep -m1 '^# ' "$f" | sed 's/^# //')
  status=$(grep -m1 -iE '^(status:|\*\*status\*\*:)' "$f" | sed -E 's/^[^:]*:[[:space:]]*//')
  if [ -z "$status" ]; then
    status=$(awk 'tolower($0) ~ /^## status/ {getline; while ($0=="") getline; print; exit}' "$f")
  fi
  printf '  %s | %s | %s\n' "$name" "${status:-?}" "${title:-?}"
done
