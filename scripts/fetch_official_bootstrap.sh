#!/usr/bin/env bash
set -euo pipefail

WORKSPACE_DIR="${1:-/root/.openclaw/workspace}"
DEST="$WORKSPACE_DIR/BOOTSTRAP.md"
SOUL="$WORKSPACE_DIR/SOUL.md"
USER_FILE="$WORKSPACE_DIR/USER.md"
URL="https://raw.githubusercontent.com/openclaw/openclaw/main/docs/reference/templates/BOOTSTRAP.md"
TMP="$(mktemp "$WORKSPACE_DIR/.bootstrap.tmp.XXXXXX")"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
TRASH_DIR="$WORKSPACE_DIR/.trash"

mkdir -p "$WORKSPACE_DIR" "$TRASH_DIR"

cleanup() {
  rm -f "$TMP"
}
trap cleanup EXIT

if [[ -f "$SOUL" ]]; then
  mv "$SOUL" "$TRASH_DIR/SOUL.md.$TIMESTAMP"
fi

if [[ -f "$USER_FILE" ]]; then
  mv "$USER_FILE" "$TRASH_DIR/USER.md.$TIMESTAMP"
fi

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL" -o "$TMP"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$TMP" "$URL"
else
  echo "Neither curl nor wget is available." >&2
  exit 1
fi

mv "$TMP" "$DEST"
echo "Fetched official BOOTSTRAP.md to: $DEST"
echo "Archived existing SOUL.md to: $TRASH_DIR/SOUL.md.$TIMESTAMP (if present)"
echo "Archived existing USER.md to: $TRASH_DIR/USER.md.$TIMESTAMP (if present)"
