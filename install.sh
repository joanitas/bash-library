#!/bin/bash

# Installation script for bash-library
# This script installs the bash library system-wide

set -euo pipefail

# Configuration
INSTALL_DIR="${BASH_LIBRARY_PATH:-/usr/local/lib/bash-library}"
BIN_DIR="/usr/local/bin"
PROFILE_DIR="/etc/profile.d"

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Create source directory structure if it doesn't exist
echo "Creating source directory structure..."
mkdir -p modules scripts

# Create installation directory
echo "Creating installation directory..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/modules"
mkdir -p "$INSTALL_DIR/scripts"
mkdir -p "$BIN_DIR"

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

# Create system-wide profile script
echo "Creating system-wide profile script..."
mkdir -p "$PROFILE_DIR"
{
    echo "# Bash Library"
    echo "export BASH_LIBRARY_PATH=\"$INSTALL_DIR\""
    echo "export PATH=\"\$PATH:$BIN_DIR\""
    echo "source \"$INSTALL_DIR/lib-loader.sh\""
} > "$PROFILE_DIR/bash-library.sh"
chmod 644 "$PROFILE_DIR/bash-library.sh"

# Add to user shell initialization
echo "Adding to user shell initialization..."
for shell_rc in ~/.bashrc ~/.zshrc; do
    if [ -f "$shell_rc" ]; then
        if ! grep -q "source $INSTALL_DIR/lib-loader.sh" "$shell_rc"; then
            {
                echo "# Bash Library"
                echo "export BASH_LIBRARY_PATH=\"$INSTALL_DIR\""
                echo "export PATH=\"\$PATH:$BIN_DIR\""
                echo "source \"$INSTALL_DIR/lib-loader.sh\""
            } >> "$shell_rc"
        fi
    fi
done

echo "Installation complete!"
echo "The bash library is now available system-wide."
echo "You may need to restart your shell or run: source /etc/profile.d/bash-library.sh" 