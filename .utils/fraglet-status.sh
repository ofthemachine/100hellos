#!/bin/bash
# fraglet-status.sh - Dynamic status and next language determination for fraglet support
#
# Usage:
#   ./fraglet-status.sh status    - Show current status (enabled, pending, next)
#   ./fraglet-status.sh next       - Return the next language to implement
#   ./fraglet-status.sh enabled    - List all enabled languages
#   ./fraglet-status.sh pending    - List all pending languages

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
LANGUAGES_FILE="$REPO_ROOT/FRAGLET_LANGUAGES.txt"

if [[ ! -f "$LANGUAGES_FILE" ]]; then
    echo "Error: FRAGLET_LANGUAGES.txt not found at $LANGUAGES_FILE" >&2
    exit 1
fi

# Get currently enabled languages (those with fraglet/ directory)
get_enabled() {
    find "$REPO_ROOT" -type d -name fraglet 2>/dev/null | \
        sed "s|^$REPO_ROOT/||" | \
        cut -f1 -d/ | \
        sort
}

# Get all target languages from enumeration file
get_targets() {
    grep -v '^[[:space:]]*$' "$LANGUAGES_FILE" | \
        grep -v '^[[:space:]]*#' | \
        sort
}

# Get pending languages (targets minus enabled)
get_pending() {
    comm -23 <(get_targets) <(get_enabled)
}

# Get next language (first pending)
get_next() {
    get_pending | head -1
}

case "${1:-status}" in
    status)
        enabled_count=$(get_enabled | wc -l)
        pending_count=$(get_pending | wc -l)
        next=$(get_next)

        echo "## Current Status"
        echo ""
        echo "- **Enabled**: $enabled_count languages"
        echo "- **Pending**: $pending_count languages"
        if [[ -n "$next" ]]; then
            echo "- **Next**: $next"
        else
            echo "- **Next**: (all complete!)"
        fi
        echo ""
        echo "### Enabled Languages"
        get_enabled | sed 's/^/  - /'
        ;;
    next)
        next=$(get_next)
        if [[ -n "$next" ]]; then
            echo "$next"
        else
            echo "All languages are enabled!" >&2
            exit 1
        fi
        ;;
    enabled)
        get_enabled
        ;;
    pending)
        get_pending
        ;;
    *)
        echo "Usage: $0 {status|next|enabled|pending}" >&2
        exit 1
        ;;
esac
