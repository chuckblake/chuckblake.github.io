#!/usr/bin/env bash
# cb-hook-shim — always runs the canonical hook so this copy can never drift.
# Canonical: ~/.claude/skills/cb-lib/hooks/cb-branch-guard.sh (kept current by cb-workflow bin/sync).
set -euo pipefail
canonical="${HOME:-}/.claude/skills/cb-lib/hooks/cb-branch-guard.sh"
if [ ! -r "$canonical" ]; then
  # Fresh machine / cb-lib not synced / unreadable: FAIL OPEN, never block a commit opaquely.
  echo "cb: canonical hook not found or unreadable ($canonical) — skipping. Run cb-workflow bin/sync." >&2
  exit 0
fi
exec bash "$canonical"
