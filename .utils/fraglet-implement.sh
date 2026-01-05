#!/bin/bash
# fraglet-implement.sh - Helper script to implement fraglet support for next language
#
# Usage:
#   ./fraglet-implement.sh [language]
#   If language is not provided, uses the next pending language from fraglet-status.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROMPT_FILE="$SCRIPT_DIR/fraglet-implement-prompt.md"
STATUS_SCRIPT="$SCRIPT_DIR/fraglet-status.sh"

# Get language (from arg or next pending)
if [[ $# -gt 0 ]]; then
    LANGUAGE="$1"
else
    LANGUAGE=$("$STATUS_SCRIPT" next)
    if [[ -z "$LANGUAGE" ]]; then
        echo "Error: No pending languages found" >&2
        exit 1
    fi
fi

# Validate language exists
if [[ ! -d "$REPO_ROOT/$LANGUAGE" ]]; then
    echo "Error: Language directory not found: $LANGUAGE" >&2
    exit 1
fi

# Check if already enabled
if [[ -d "$REPO_ROOT/$LANGUAGE/fraglet" ]]; then
    echo "Warning: $LANGUAGE already has fraglet support" >&2
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Generate prompt with language substituted
PROMPT=$(sed "s/{LANGUAGE}/$LANGUAGE/g" "$PROMPT_FILE")

# Create temporary file for prompt (in workspace so MCP servers are available)
TEMP_PROMPT=$(mktemp "$REPO_ROOT/.fraglet-prompt-XXXXXX.txt")
echo "$PROMPT" > "$TEMP_PROMPT"

# Cleanup function
cleanup() {
    rm -f "$TEMP_PROMPT"
}
trap cleanup EXIT

# Display what we're doing
echo "Implementing fraglet support for: $LANGUAGE"
echo ""

# Check if Cursor CLI is available
if ! command -v cursor-agent &> /dev/null; then
    echo "Error: Cursor CLI not found in PATH" >&2
    echo ""
    echo "Prompt saved to: $TEMP_PROMPT"
    echo "Install Cursor CLI or manually invoke:"
    echo "  cd $REPO_ROOT && cursor-agent < $TEMP_PROMPT"
    exit 1
fi

# Invoke Cursor CLI non-interactively from workspace directory
# This ensures MCP servers configured for the workspace are available
echo "Invoking Cursor CLI non-interactively..."
echo "Working directory: $REPO_ROOT"
echo "Prompt file: $TEMP_PROMPT"
echo ""

cd "$REPO_ROOT"
cursor-agent < "$TEMP_PROMPT"
EXIT_CODE=$?

if [[ $EXIT_CODE -eq 0 ]]; then
    echo ""
    echo "✓ Cursor CLI completed successfully"
else
    echo ""
    echo "✗ Cursor CLI exited with code: $EXIT_CODE" >&2
    echo "Prompt file preserved at: $TEMP_PROMPT"
    exit $EXIT_CODE
fi
