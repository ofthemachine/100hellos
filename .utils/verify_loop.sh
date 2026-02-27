#!/usr/bin/env bash
# verify_loop.sh - Sequential overlay build + verify for each language.
#
# Maintains a progress file (.verify-passed) tracking languages that have
# passed. On re-run, skips already-passed languages. On failure, exits
# immediately with details so you can investigate, fix, and re-run.
#
# Usage:
#   verify_loop.sh                        # all languages with fraglet/ dirs
#   verify_loop.sh [lang1 lang2 ...]      # specific languages only
#   verify_loop.sh --reset                # clear progress and start fresh

set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

PROGRESS_FILE=".verify-passed"

if [ "${1:-}" = "--reset" ]; then
  rm -f "$PROGRESS_FILE"
  echo "Progress reset."
  exit 0
fi

touch "$PROGRESS_FILE"

REJECTED_FILE=".rejected-languages"

if [ $# -gt 0 ]; then
  langs="$*"
else
  langs=$(ls -d */fraglet 2>/dev/null | sed 's|/fraglet||' | sort)
fi

skipped=0
passed=0

for lang in $langs; do
  if [ -f "$REJECTED_FILE" ] && grep -qx "$lang" "$REJECTED_FILE" 2>/dev/null; then
    continue
  fi

  if grep -qx "$lang" "$PROGRESS_FILE" 2>/dev/null; then
    skipped=$((skipped + 1))
    continue
  fi

  if [ $skipped -gt 0 ]; then
    echo "  (skipped $skipped already-passed)"
    skipped=0
  fi

  # Overlay build
  echo "--- $lang: building overlay..."
  build_output=$(.utils/overlay_build.sh "$lang" 2>&1) || {
    echo "FAIL $lang: overlay build"
    echo "$build_output"
    exit 1
  }

  # verify_args.sh
  if [ -f "$lang/fraglet/verify_args.sh" ]; then
    args_output=$(bash "$lang/fraglet/verify_args.sh" 2>&1) || {
      echo "FAIL $lang: verify_args.sh"
      echo "$args_output"
      echo ""
      echo "To retry after fixing: .utils/verify_loop.sh"
      exit 1
    }
  fi

  # verify_stdin.sh
  if [ -f "$lang/fraglet/verify_stdin.sh" ]; then
    stdin_output=$(bash "$lang/fraglet/verify_stdin.sh" 2>&1) || {
      echo "FAIL $lang: verify_stdin.sh"
      echo "$stdin_output"
      echo ""
      echo "To retry after fixing: .utils/verify_loop.sh"
      exit 1
    }
  fi

  # All passed for this language
  echo "$lang" >> "$PROGRESS_FILE"
  passed=$((passed + 1))

  has_args=$( [ -f "$lang/fraglet/verify_args.sh" ] && echo "args" || echo "" )
  has_stdin=$( [ -f "$lang/fraglet/verify_stdin.sh" ] && echo "stdin" || echo "" )
  checks=$(echo "$has_args $has_stdin" | xargs)
  echo "  ✓ $lang ($checks)"
done

if [ $skipped -gt 0 ]; then
  echo "  (skipped $skipped already-passed)"
fi

total=$(wc -l < "$PROGRESS_FILE" | tr -d ' ')
echo ""
echo "Done. $passed newly passed, $total total passed."
