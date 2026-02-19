#!/bin/bash
# fraglet-status.sh - Dynamic status and next language determination for fraglet support
#
# Usage:
#   ./fraglet-status.sh status      - Show current status (enabled, pending, next)
#   ./fraglet-status.sh next        - Return the next language to implement
#   ./fraglet-status.sh enabled     - List all enabled languages
#   ./fraglet-status.sh pending     - List all pending languages
#   ./fraglet-status.sh skipped     - List all intentionally skipped languages
#   ./fraglet-status.sh verified    - List languages with full capabilities (base + stdin/args ✓ or N/A)
#   ./fraglet-status.sh capabilities - Show capabilities table (derived from script presence)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
LANGUAGES_FILE="$REPO_ROOT/FRAGLET_LANGUAGES.txt"
FUNCTIONS_FILE="$SCRIPT_DIR/functions.sh"

if [[ ! -f "$LANGUAGES_FILE" ]]; then
    echo "Error: FRAGLET_LANGUAGES.txt not found at $LANGUAGES_FILE" >&2
    exit 1
fi

# Source functions to get published_languages
if [[ -f "$FUNCTIONS_FILE" ]]; then
    source "$FUNCTIONS_FILE"
else
    echo "Error: functions.sh not found at $FUNCTIONS_FILE" >&2
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

# Get skipped languages (published languages that are not in targets and not enabled)
get_skipped() {
    (
        cd "$REPO_ROOT"
        comm -23 <(published_languages | sort) <(get_targets) | \
        comm -23 - <(get_enabled)
    )
}

# Capability detection (local to 100hellos: script presence only)
# Base = verify.sh, Stdin = verify_stdin.sh (or N/A for ats), Args = verify_args.sh (or N/A for ats)
cap_detect_one() {
    local lang="$1"
    local d="$REPO_ROOT/$lang"
    local base="—"
    local stdin="—"
    local args="—"
    [[ -f "$d/fraglet/verify.sh" ]] && base="✓"
    if [[ -f "$d/fraglet/verify_stdin.sh" ]]; then
        stdin="✓"
    elif [[ "$lang" == "ats" ]]; then
        stdin="N/A"
    fi
    if [[ -f "$d/fraglet/verify_args.sh" ]]; then
        args="✓"
    elif [[ "$lang" == "ats" ]]; then
        args="N/A"
    fi
    echo "$lang	$base	$stdin	$args"
}

# All published languages (sorted)
get_published() {
    (cd "$REPO_ROOT" && published_languages | sort)
}

# Get verified languages: base ✓ and (stdin ✓ or N/A) and (args ✓ or N/A)
get_verified() {
    local lang
    while IFS= read -r lang; do
        [[ -n "$lang" ]] || continue
        local row
        row=$(cap_detect_one "$lang")
        local base stdin args
        IFS=$'\t' read -r _ base stdin args <<< "$row"
        if [[ "$base" == "✓" && ("$stdin" == "✓" || "$stdin" == "N/A") && ("$args" == "✓" || "$args" == "N/A") ]]; then
            echo "$lang"
        fi
    done < <(get_published)
}

# Emit full capabilities table (markdown) for all published languages
emit_capabilities_table() {
    echo "| Language | Injectable (base) | Stdin support | Arg support |"
    echo "|----------|-------------------|---------------|-------------|"
    local lang
    while IFS= read -r lang; do
        [[ -n "$lang" ]] || continue
        local row
        row=$(cap_detect_one "$lang")
        local name base stdin args
        IFS=$'\t' read -r name base stdin args <<< "$row"
        echo "| $name | $base | $stdin | $args |"
    done < <(get_published)
}

case "${1:-status}" in
    status)
        enabled_count=$(get_enabled | wc -l)
        pending_count=$(get_pending | wc -l)
        verified_count=$(get_verified | wc -l)
        next=$(get_next)

        echo "## Current Status"
        echo ""
        echo "- **Enabled**: $enabled_count languages"
        echo "- **Pending**: $pending_count languages"
        echo "- **Verified** (stdin/args contract): $verified_count languages"
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
    skipped)
        get_skipped
        ;;
    verified)
        get_verified
        ;;
    capabilities)
        emit_capabilities_table
        ;;
    *)
        echo "Usage: $0 {status|next|enabled|pending|skipped|verified|capabilities}" >&2
        exit 1
        ;;
esac
