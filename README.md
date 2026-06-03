# Continuum Distribution

Public Linux, macOS, and Windows distribution repository for the Continuum VS Code extension.

This repository only hosts prebuilt VSIX binaries and installation helpers.

## Install The Latest Release (Linux & macOS)

### One-liner (Recommended, no leftover files)

```bash
curl -fsSL https://raw.githubusercontent.com/sjseo298/continuum-distribution/main/install-continuum.sh | bash
```

Choose a specific editor:

```bash
# VS Code stable
curl -fsSL https://raw.githubusercontent.com/sjseo298/continuum-distribution/main/install-continuum.sh | bash -s -- --editor code

# Code Insiders
curl -fsSL https://raw.githubusercontent.com/sjseo298/continuum-distribution/main/install-continuum.sh | bash -s -- --editor code-insiders
```

### Safe install (review the script first)

```bash
wget -O install-continuum.sh https://raw.githubusercontent.com/sjseo298/continuum-distribution/main/install-continuum.sh
chmod +x install-continuum.sh
./install-continuum.sh
```

## Install The Latest Release (Windows)

### One-liner (Recommended, no leftover files)

Run the following in PowerShell:

```powershell
$version = "0.5.0" # update to latest version on each release
$url = "https://github.com/sjseo298/continuum-distribution/releases/latest/download/continuum-$($version).vsix"
Invoke-WebRequest -Uri $url -OutFile continuum.vsix
code --install-extension continuum.vsix
Remove-Item continuum.vsix
```

Install into **Code Insiders** instead:

```powershell
$version = "0.5.0" # update to latest version on each release
$url = "https://github.com/sjseo298/continuum-distribution/releases/latest/download/continuum-$($version).vsix"
Invoke-WebRequest -Uri $url -OutFile continuum.vsix
code-insiders --install-extension continuum.vsix
Remove-Item continuum.vsix
```

### Safe install (manual download)

Download the latest `.vsix` from [releases](https://github.com/sjseo298/continuum-distribution/releases), then:

```powershell
# VS Code stable
code --install-extension continuum-0.5.0.vsix

# Or Code Insiders
code-insiders --install-extension continuum-0.5.0.vsix
```

---

## Editor Selection (Linux & macOS)

The one-liner installer detects your editor automatically. You can also specify one explicitly:

```bash
curl -fsSL https://raw.githubusercontent.com/sjseo298/continuum-distribution/main/install-continuum.sh | bash -s -- --editor codium
```

Supported editor commands:

- `code` — VS Code (Linux/macOS)
- `code-insiders` / `vscode-insiders` — VS Code Insiders
- `codium` — VSCodium
- `cursor` — Cursor IDE
- `windsurf` — Windsurf

## Manual Install (Any OS)

1. Open the latest release in this repository.
2. Download the `.vsix` asset.
3. Install it in your editor:

```bash
code --install-extension continuum-0.5.0.vsix
```

For **Code Insiders**, use `code-insiders` instead of `code`:

```bash
code-insiders --install-extension continuum-0.5.0.vsix
```

## Notes

- The one-liner uses `curl` and the GitHub Releases API (`/releases`) to fetch the latest VSIX, including pre-releases.
- Only the 3 latest distribution releases are retained.
