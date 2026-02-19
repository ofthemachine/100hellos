#!/bin/bash
# run-verify.sh - Run fraglet verify script(s) for a language using fragletc
#
# Usage:
#   ./run-verify.sh <LANGUAGE> [CAPABILITY] [IMAGE]
#
# CAPABILITY: optional. Omit or "base" = run verify.sh (default run + guide).
#             "stdin" = run verify_stdin.sh if present (verified stdin capability).
#             "args"  = run verify_args.sh if present (verified args capability).
# IMAGE: optional, default 100hellos/<LANGUAGE>:local
#
# Verified capabilities detection: presence of verify_stdin.sh / verify_args.sh
# means the language claims that capability; running them verifies it.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <LANGUAGE> [CAPABILITY] [IMAGE]" >&2
    echo "  LANGUAGE   e.g. ats, scala" >&2
    echo "  CAPABILITY optional: base (default), stdin, args" >&2
    echo "  IMAGE      optional, default 100hellos/<LANGUAGE>:local" >&2
    exit 1
fi

LANGUAGE="$1"
CAPABILITY="${2:-base}"
IMAGE="${3:-100hellos/${LANGUAGE}:local}"

# If second arg looks like an image (contains / or :), treat as IMAGE and use base
if [[ "$CAPABILITY" == *"/"* || "$CAPABILITY" == *":"* ]]; then
    IMAGE="$CAPABILITY"
    CAPABILITY="base"
fi

case "$CAPABILITY" in
    base)  VERIFY_SCRIPT="$REPO_ROOT/$LANGUAGE/fraglet/verify.sh" ;;
    stdin) VERIFY_SCRIPT="$REPO_ROOT/$LANGUAGE/fraglet/verify_stdin.sh" ;;
    args)  VERIFY_SCRIPT="$REPO_ROOT/$LANGUAGE/fraglet/verify_args.sh" ;;
    *)
        echo "Error: CAPABILITY must be base, stdin, or args" >&2
        exit 1
        ;;
esac

if [[ ! -f "$VERIFY_SCRIPT" ]]; then
    echo "Error: $VERIFY_SCRIPT not found" >&2
    exit 1
fi

if [[ -n "${FRAGLET_REPO:-}" && -d "$FRAGLET_REPO" ]]; then
    (cd "$FRAGLET_REPO" && make install-cli) >/dev/null 2>&1
    export PATH="$(go env GOPATH 2>/dev/null)/bin:$(go env GOBIN 2>/dev/null):$PATH"
fi

if ! command -v fragletc >/dev/null 2>&1; then
    echo "Error: fragletc not found in PATH" >&2
    echo "Set FRAGLET_REPO to the fraglet repo path, or run from fraglet repo after: make install-cli" >&2
    exit 1
fi

chmod +x "$VERIFY_SCRIPT"
exec "$VERIFY_SCRIPT" "$IMAGE"
