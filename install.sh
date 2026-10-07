#!/usr/bin/env bash
#
# install.sh — offline installer for the Microsoft reveal.js theme (Linux)
#
# What it does:
#   1. Copies the presentation assets to  $MY_REVEAL_DIR  (default: ~/.my_reveal)
#   2. Installs the  nova_apresentacao_md  command to  $BIN_DIR  (default: ~/.local/bin)
#
# Usage:
#   ./install.sh                              # from a cloned repo
#   curl -fsSL <url>/install.sh | bash        # standalone (downloads the assets)
#
# Environment overrides:
#   MY_REVEAL_DIR   where to install the assets   (default: ~/.my_reveal)
#   BIN_DIR         where to install the command  (default: ~/.local/bin)
#
set -euo pipefail

MY_REVEAL_DIR="${MY_REVEAL_DIR:-$HOME/.my_reveal}"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"
REPO_TARBALL="https://codeload.github.com/wesleyit/my_reveal/tar.gz/refs/heads/main"

say() { printf '  %s\n' "$*"; }

echo "Installing Microsoft reveal.js (offline)…"

# --- 1. Locate the source (local checkout or download) -----------------------
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
cleanup=""
if [ -d "$script_dir/assets" ] && [ -d "$script_dir/templates" ]; then
    src="$script_dir"
    say "Using local checkout: $src"
else
    command -v curl >/dev/null 2>&1 || { echo "curl is required to download the assets." >&2; exit 1; }
    tmp="$(mktemp -d)"
    cleanup="$tmp"
    say "Downloading assets from GitHub…"
    curl -fsSL "$REPO_TARBALL" | tar xz -C "$tmp" --strip-components=1
    src="$tmp"
fi

# --- 2. Install the assets ----------------------------------------------------
say "Installing assets to $MY_REVEAL_DIR"
rm -rf "$MY_REVEAL_DIR"
mkdir -p "$MY_REVEAL_DIR"
cp -r "$src/assets/." "$MY_REVEAL_DIR/"
cp -r "$src/templates" "$MY_REVEAL_DIR/templates"

# --- 3. Install the command ---------------------------------------------------
say "Installing command to $BIN_DIR/nova_apresentacao_md"
mkdir -p "$BIN_DIR"
cp "$src/bin/nova_apresentacao_md" "$BIN_DIR/nova_apresentacao_md"
chmod +x "$BIN_DIR/nova_apresentacao_md"
cp "$src/bin/apresentar" "$BIN_DIR/apresentar"
chmod +x "$BIN_DIR/apresentar"

[ -n "$cleanup" ] && rm -rf "$cleanup"

echo
echo "Done!"
echo
case ":$PATH:" in
    *":$BIN_DIR:"*) ;;
    *)
        echo "NOTE: $BIN_DIR is not on your PATH. Add this to your ~/.bashrc:"
        echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
        echo
        ;;
esac
echo "Create a new deck with:"
echo "    nova_apresentacao_md dark minha_palestra"
echo "Then present it offline with:"
echo "    apresentar minha_palestra.html"
