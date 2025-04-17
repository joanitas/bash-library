#!/bin/bash

# Remote uninstallation script for bash-library
# This script can be run with: curl -sSL https://raw.githubusercontent.com/hperezrodal/bash-library/main/uninstall-remote.sh | bash

set -euo pipefail

# Configuration
INSTALL_DIR="${BASH_LIBRARY_PATH:-$HOME/.local/lib/bash-library}"
BIN_DIR="$HOME/.local/bin"

# Check if installation exists
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Error: bash-library is not installed."
    exit 1
fi

# Remove installation directory
echo "Removing installation directory..."
rm -rf "$INSTALL_DIR"

# Remove symlinks
echo "Removing symlinks..."
for script in "$BIN_DIR"/*; do
    if [ -L "$script" ] && [ "$(readlink "$script")" == "$INSTALL_DIR/scripts/$(basename "$script").sh" ]; then
        rm "$script"
    fi
done

# Remove from shell initialization
echo "Removing from shell initialization..."
for shell_rc in ~/.bashrc ~/.zshrc; do
    if [ -f "$shell_rc" ]; then
        sed -i.bak '/BASH_LIBRARY_PATH/d' "$shell_rc"
        sed -i.bak '/source.*bash-library/d' "$shell_rc"
        rm "${shell_rc}.bak"
    fi
done

echo "Uninstallation complete!"
echo "You may need to restart your shell for changes to take effect." 