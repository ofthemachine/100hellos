#!/bin/bash
# batch-of-10.sh - Batch process 10 pending languages for fraglet implementation
#
# Usage:
#   ./batch-of-10.sh
#
# This script will:
# 1. Get the list of pending languages
# 2. Take the first 10
# 3. Invoke fraglet-implement.sh for each one sequentially

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
STATUS_SCRIPT="$REPO_ROOT/.utils/fraglet-status.sh"
IMPLEMENT_SCRIPT="$REPO_ROOT/.utils/fraglet-implement.sh"

# Check if helper scripts exist
if [[ ! -f "$STATUS_SCRIPT" ]]; then
    echo "Error: fraglet-status.sh not found at $STATUS_SCRIPT" >&2
    exit 1
fi

if [[ ! -f "$IMPLEMENT_SCRIPT" ]]; then
    echo "Error: fraglet-implement.sh not found at $IMPLEMENT_SCRIPT" >&2
    exit 1
fi

# Get pending languages and take first 10
PENDING_LANGUAGES=$("$STATUS_SCRIPT" pending | head -10)

if [[ -z "$PENDING_LANGUAGES" ]]; then
    echo "No pending languages found!" >&2
    exit 1
fi

# Count how many we have
LANGUAGE_COUNT=$(echo "$PENDING_LANGUAGES" | grep -c . || echo "0")

if [[ "$LANGUAGE_COUNT" -eq 0 ]]; then
    echo "No pending languages found!" >&2
    exit 1
fi

echo "=========================================="
echo "Batch Fraglet Implementation"
echo "=========================================="
echo "Processing $LANGUAGE_COUNT language(s):"
echo "$PENDING_LANGUAGES" | sed 's/^/  - /'
echo ""
echo "Starting batch processing..."
echo ""

# Process each language
SUCCESS_COUNT=0
FAIL_COUNT=0
FAILED_LANGUAGES=()

while IFS= read -r LANGUAGE; do
    [[ -z "$LANGUAGE" ]] && continue
    
    echo ""
    echo "=========================================="
    echo "[$((SUCCESS_COUNT + FAIL_COUNT + 1))/$LANGUAGE_COUNT] Processing: $LANGUAGE"
    echo "=========================================="
    
    if "$IMPLEMENT_SCRIPT" "$LANGUAGE"; then
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        echo ""
        echo "✓ Successfully completed: $LANGUAGE"
    else
        FAIL_COUNT=$((FAIL_COUNT + 1))
        FAILED_LANGUAGES+=("$LANGUAGE")
        echo ""
        echo "✗ Failed: $LANGUAGE"
    fi
    
    echo ""
    echo "---"
done <<< "$PENDING_LANGUAGES"

# Summary
echo ""
echo "=========================================="
echo "Batch Processing Complete"
echo "=========================================="
echo "Total processed: $LANGUAGE_COUNT"
echo "Successful: $SUCCESS_COUNT"
echo "Failed: $FAIL_COUNT"
echo ""

if [[ $FAIL_COUNT -gt 0 ]]; then
    echo "Failed languages:"
    for lang in "${FAILED_LANGUAGES[@]}"; do
        echo "  - $lang"
    done
    echo ""
    exit 1
else
    echo "✓ All languages processed successfully!"
    exit 0
fi
