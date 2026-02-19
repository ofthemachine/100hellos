#!/bin/bash
# run-all-verify.sh - For each language with fraglet/verify.sh: build image then run all capability verifies.
#
# Usage:
#   ./run-all-verify.sh [LANG ...]
#
# With no arguments: iterates every language that has fraglet/verify.sh,
# runs `make <lang>` then run-verify.sh for base, stdin (if verify_stdin.sh exists), args (if verify_args.sh exists).
# With arguments: only those languages (e.g. ./run-all-verify.sh scala java).
#
# Capabilities are determined by script presence; passing scripts = verified.
# Requires fragletc on PATH. Run from 100hellos repo root.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$REPO_ROOT"

if [[ $# -ge 1 ]]; then
  LANGS=("$@")
else
  LANGS=()
  for d in "$REPO_ROOT"/*/; do
    lang=$(basename "$d")
    [[ -f "$d/fraglet/verify.sh" ]] && LANGS+=("$lang")
  done
  LANGS=($(printf '%s\n' "${LANGS[@]}" | sort))
fi

run_cap() {
  local lang="$1"
  local cap="$2"
  bash ".utils/run-verify.sh" "$lang" "$cap" 2>&1
}

failed=0
for lang in "${LANGS[@]}"; do
  if [[ ! -f "$REPO_ROOT/$lang/fraglet/verify.sh" ]]; then
    echo "SKIP: $lang (no fraglet/verify.sh)" >&2
    continue
  fi
  echo "=== $lang ==="
  if ! make "$lang"; then
    echo "FAIL: $lang (make failed)" >&2
    ((failed++)) || true
    continue
  fi
  caps=("base")
  out=$(run_cap "$lang" "")
  if ! echo "$out" | tail -1 | grep -q "All tests passed"; then
    echo "FAIL: $lang (base)" >&2
    ((failed++)) || true
    continue
  fi
  if [[ -f "$REPO_ROOT/$lang/fraglet/verify_stdin.sh" ]]; then
    out=$(run_cap "$lang" "stdin")
    if ! echo "$out" | tail -1 | grep -q "stdin verified"; then
      echo "FAIL: $lang (stdin)" >&2
      ((failed++)) || true
      continue
    fi
    caps+=("stdin")
  fi
  if [[ -f "$REPO_ROOT/$lang/fraglet/verify_args.sh" ]]; then
    out=$(run_cap "$lang" "args")
    if ! echo "$out" | tail -1 | grep -q "args verified"; then
      echo "FAIL: $lang (args)" >&2
      ((failed++)) || true
      continue
    fi
    caps+=("args")
  fi
  echo "PASS: $lang ($(IFS=,; echo "${caps[*]}"))"
done
[[ $failed -eq 0 ]] || exit 1
