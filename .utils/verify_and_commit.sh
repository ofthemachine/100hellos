#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

PROGRESS_FILE=".verify-passed"
REJECTED_FILE=".rejected-languages"

if [ "${1:-}" = "--reset" ]; then
  rm -f "$PROGRESS_FILE"
  echo "Progress reset."
  exit 0
fi

touch "$PROGRESS_FILE"

langs=$(ls -d */fraglet 2>/dev/null | sed 's|/fraglet||' | sort)

skipped=0
passed=0

first_commit_msg() {
  local lang="$1"
  git log --oneline --diff-filter=A -- "$lang/" | tail -1 | sed 's/^[0-9a-f]* //'
}

for lang in $langs; do
  if grep -qx "$lang" "$PROGRESS_FILE" 2>/dev/null; then
    skipped=$((skipped + 1))
    continue
  fi

  if [ $skipped -gt 0 ]; then
    echo "  (skipped $skipped already-committed)"
    skipped=0
  fi

  is_rejected=false
  if [ -f "$REJECTED_FILE" ] && grep -qx "$lang" "$REJECTED_FILE" 2>/dev/null; then
    is_rejected=true
  fi

  if [ "$is_rejected" = "false" ]; then
    echo "--- $lang: building overlay..."
    build_output=$(.utils/overlay_build.sh "$lang" 2>&1) || {
      echo "FAIL $lang: overlay build"
      echo "$build_output"
      exit 1
    }

    has_args=false
    has_stdin=false

    if [ -f "$lang/fraglet/verify_args.sh" ]; then
      has_args=true
      args_output=$(bash "$lang/fraglet/verify_args.sh" 2>&1) || {
        echo "FAIL $lang: verify_args.sh"
        echo "$args_output"
        exit 1
      }
    fi

    if [ -f "$lang/fraglet/verify_stdin.sh" ]; then
      has_stdin=true
      stdin_output=$(bash "$lang/fraglet/verify_stdin.sh" 2>&1) || {
        echo "FAIL $lang: verify_stdin.sh"
        echo "$stdin_output"
        exit 1
      }
    fi

    caps=""
    if [ "$has_stdin" = "true" ] && [ "$has_args" = "true" ]; then
      caps=" (stdin/args)"
    elif [ "$has_stdin" = "true" ]; then
      caps=" (stdin)"
    elif [ "$has_args" = "true" ]; then
      caps=" (args)"
    fi

    base_msg=$(first_commit_msg "$lang")
    if [ -z "$base_msg" ]; then
      base_msg="$lang says Hello!"
    fi
    commit_msg="$base_msg + fraglet${caps}"
  else
    commit_msg="$lang + fraglet (rejected)"
  fi

  git add "$lang/"
  if ! git diff --cached --quiet -- "$lang/"; then
    git commit -m "$commit_msg"
    echo "  ✓ $lang committed: $commit_msg"
  else
    echo "  ✓ $lang (no changes to commit)"
  fi

  echo "$lang" >> "$PROGRESS_FILE"
  passed=$((passed + 1))
done

if [ $skipped -gt 0 ]; then
  echo "  (skipped $skipped already-committed)"
fi

total=$(wc -l < "$PROGRESS_FILE" | tr -d ' ')
echo ""
echo "Done. $passed newly committed, $total total."
