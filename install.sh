#!/bin/bash

# Installation script for bash-library
# This script installs the bash library system-wide

set -euo pipefail

# Default installation directory
INSTALL_DIR="/usr/local/lib/bash-library"
BIN_DIR="/usr/local/bin"

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Create installation directory
echo "Creating installation directory..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/modules"
mkdir -p "$INSTALL_DIR/scripts"

# Copy library files
echo "Copying library files..."
cp -r modules/* "$INSTALL_DIR/modules/"
cp -r scripts/* "$INSTALL_DIR/scripts/"
cp lib-loader.sh "$INSTALL_DIR/"

# Create symlinks for scripts
echo "Creating symlinks for scripts..."
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

# Add to shell initialization
echo "Adding to shell initialization..."
for shell_rc in ~/.bashrc ~/.zshrc; do
    if [ -f "$shell_rc" ]; then
        if ! grep -q "source $INSTALL_DIR/lib-loader.sh" "$shell_rc"; then
            {
                echo "# Bash Library"
                echo "export BASH_LIBRARY_PATH=\"$INSTALL_DIR\""
                echo "source \"$INSTALL_DIR/lib-loader.sh\""
            } >> "$shell_rc"
        fi
    fi
done

echo "Installation complete!"
echo "The bash library is now available system-wide."
echo "You may need to restart your shell or run: source ~/.bashrc" 