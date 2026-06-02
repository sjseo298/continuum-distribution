#!/usr/bin/env bash
set -euo pipefail

DISTRO_REPO="sjseo298/continuum-distribution"
TMP_DIR="$(mktemp -d)"
EDITOR_CMD=""

cleanup() {
  rm -rf "$TMP_DIR"
}

trap cleanup EXIT

usage() {
  cat <<EOF
Usage: $0 [--editor COMMAND] [--repo owner/repo]

Options:
  --editor COMMAND  VS Code-compatible editor command to use
  --repo REPO       Distribution repo to query (default: $DISTRO_REPO)
  --help, -h        Show this help

Supported editors include: code, code-insiders, codium, cursor, windsurf
EOF
}

detect_editor() {
  for command in code cursor codium code-insiders windsurf; do
    if command -v "$command" >/dev/null 2>&1; then
      echo "$command"
      return 0
    fi
  done

  return 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --editor)
      EDITOR_CMD="$2"
      shift 2
      ;;
    --repo)
      DISTRO_REPO="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$EDITOR_CMD" ]]; then
  if ! EDITOR_CMD="$(detect_editor)"; then
    echo "Could not detect a VS Code-compatible editor command." >&2
    echo "Pass one explicitly, for example: --editor code" >&2
    exit 1
  fi
fi

if ! command -v wget >/dev/null 2>&1; then
  echo "wget is required but not installed." >&2
  exit 1
fi

if ! command -v "$EDITOR_CMD" >/dev/null 2>&1; then
  echo "Editor command '$EDITOR_CMD' was not found in PATH." >&2
  exit 1
fi

API_URL="https://api.github.com/repos/${DISTRO_REPO}/releases?per_page=30"
RELEASE_JSON="$TMP_DIR/release.json"

echo "Fetching latest release list from ${DISTRO_REPO}..."
wget -qO "$RELEASE_JSON" "$API_URL"

VSIX_URL="$({
  python3 - "$RELEASE_JSON" <<'PY'
import json
import sys

with open(sys.argv[1], 'r', encoding='utf-8') as fh:
  releases = json.load(fh)

for release in releases:
  assets = release.get('assets', [])
  for asset in assets:
    name = asset.get('name', '')
    if name.endswith('.vsix'):
      print(asset['browser_download_url'])
      raise SystemExit(0)
PY
} || true)"

if [[ -z "$VSIX_URL" ]]; then
  echo "Could not find a VSIX asset in the latest release." >&2
  exit 1
fi

VSIX_FILE="$TMP_DIR/$(basename "$VSIX_URL")"

echo "Downloading $(basename "$VSIX_FILE")..."
wget -qO "$VSIX_FILE" "$VSIX_URL"

echo "Installing into '$EDITOR_CMD'..."
"$EDITOR_CMD" --install-extension "$VSIX_FILE"

echo "Installed $(basename "$VSIX_FILE") successfully."