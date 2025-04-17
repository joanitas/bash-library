#!/bin/bash

# Uninstallation script for bash-library
# This script removes the bash library system-wide

set -euo pipefail

# Default installation directory
INSTALL_DIR="/usr/local/lib/bash-library"
BIN_DIR="/usr/local/bin"

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Remove symlinks for scripts
echo "Removing script symlinks..."
for script in "$INSTALL_DIR/scripts"/*.sh; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script" .sh)
        rm -f "$BIN_DIR/$script_name"
    fi
done

# Remove installation directory
echo "Removing installation directory..."
rm -rf "$INSTALL_DIR"

# Remove from shell initialization
echo "Removing from shell initialization..."
for shell_rc in ~/.bashrc ~/.zshrc; do
    if [ -f "$shell_rc" ]; then
        # Create a temporary file without the bash library entries
        grep -v "Bash Library" "$shell_rc" | \
        grep -v "BASH_LIBRARY_PATH" | \
        grep -v "lib-loader.sh" > "${shell_rc}.tmp"
        
        # Replace the original file with the temporary one
        mv "${shell_rc}.tmp" "$shell_rc"
    fi
done

echo "Uninstallation complete!"
echo "The bash library has been removed from your system."
echo "You may need to restart your shell or run: source ~/.bashrc" 