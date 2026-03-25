#!/bin/bash
# setup.sh
# One-time setup: copies template files into private/ for local configuration.
# Run this after cloning the repo.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PRIVATE_DIR="$SCRIPT_DIR/private"
TEMPLATES_DIR="$SCRIPT_DIR/templates"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ -d "$PRIVATE_DIR" ] && [ "$(ls -A "$PRIVATE_DIR" 2>/dev/null)" ]; then
    echo -e "${YELLOW}private/ already exists and has files. Not overwriting.${NC}"
    echo "To start fresh, remove private/ and run this script again."
    exit 1
fi

mkdir -p "$PRIVATE_DIR"

for template in "$TEMPLATES_DIR"/*.example; do
    [ -f "$template" ] || continue
    filename="$(basename "$template" .example)"
    cp "$template" "$PRIVATE_DIR/$filename"
    echo -e "${GREEN}Created:${NC} private/$filename"
done

echo ""
echo "Next steps:"
echo "  1. Edit files in private/ with your details"
echo "  2. Run ./sync-claude-context.sh to sync to Claude Code and Cowork"
