#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

OUT_DIR="dist"
OUT="$OUT_DIR/linkedin-feed-blocker.zip"

FILES=(
  "manifest.json"
  "rules.json"
  "feed.css"
  "assets/icon.png"
)

# Verify required files exist.
for file in manifest.json rules.json feed.css; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required file: $file" >&2
    exit 1
  fi
done

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

zip -r "$OUT" "${FILES[@]}"

echo
echo "Created: $OUT"
unzip -l "$OUT"
