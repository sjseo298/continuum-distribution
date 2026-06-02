# Continuum Distribution

Public Linux distribution repository for the Continuum VS Code extension.

This repository only hosts prebuilt VSIX binaries and installation helpers.

## Install The Latest Release

Run the installer directly:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/sjseo298/continuum-distribution/main/install-continuum.sh)
```

Choose a specific editor command:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/sjseo298/continuum-distribution/main/install-continuum.sh) --editor code
bash <(wget -qO- https://raw.githubusercontent.com/sjseo298/continuum-distribution/main/install-continuum.sh) --editor codium
bash <(wget -qO- https://raw.githubusercontent.com/sjseo298/continuum-distribution/main/install-continuum.sh) --editor cursor
```

Supported editor commands:

- `code`
- `code-insiders`
- `codium`
- `cursor`
- `windsurf`

## Manual Install

1. Open the latest release in this repository.
2. Download the `.vsix` asset.
3. Install it in your editor:

```bash
code --install-extension continuum-0.5.0.vsix
```

Replace `code` with your editor command if needed.

## Notes

- The installer uses `wget` and the GitHub Releases API to fetch the latest VSIX.
- Only the 3 latest distribution releases are retained.