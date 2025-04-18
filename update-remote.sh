#!/bin/bash

# Remote update script for bash-library
# This script can be run with: curl -sSL https://raw.githubusercontent.com/hperezrodal/bash-library/main/update-remote.sh | bash

set -euo pipefail

# Configuration
INSTALL_DIR="${BASH_LIBRARY_PATH:-$HOME/.local/lib/bash-library}"
BIN_DIR="$HOME/.local/bin"

# Check if installation exists
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Error: bash-library is not installed."
    echo "Please run the installation script first:"
    echo "curl -sSL https://raw.githubusercontent.com/hperezrodal/bash-library/main/install-remote.sh | bash"
    exit 1
fi

# Check if it's a git repository
if [ ! -d "$INSTALL_DIR/.git" ]; then
    echo "Error: Installation is not a git repository."
    echo "Please reinstall using the installation script:"
    echo "curl -sSL https://raw.githubusercontent.com/hperezrodal/bash-library/main/install-remote.sh | bash"
    exit 1
fi

# Update the repository
echo "Updating bash library..."
cd "$INSTALL_DIR"
if ! git pull; then
    echo "Error: Failed to update the repository."
    exit 1
fi

# Update symlinks
echo "Updating symlinks..."
for script in "$INSTALL_DIR/scripts"/*.sh; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script" .sh)
        ln -sf "$script" "$BIN_DIR/$script_name"
    fi
done

# Set permissions
echo "Setting permissions..."
chmod -R 755 "$INSTALL_DIR"
chmod 644 "$INSTALL_DIR/modules"/*.sh
chmod 755 "$INSTALL_DIR/scripts"/*.sh

echo "Update complete!"
echo "You may need to restart your shell or run: source ~/.bashrc" 