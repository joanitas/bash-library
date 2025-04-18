#!/bin/bash

# Remote installation script for bash-library
# This script can be run with: curl -sSL https://raw.githubusercontent.com/hperezrodal/bash-library/main/install-remote.sh | bash

set -euo pipefail

# Configuration
REPO_URL="https://github.com/hperezrodal/bash-library"
SYSTEM_INSTALL=${SYSTEM_INSTALL:-false}

# Determine installation paths based on whether it's a system install
if [ "$SYSTEM_INSTALL" = "true" ]; then
    INSTALL_DIR="${BASH_LIBRARY_PATH:-/usr/local/lib/bash-library}"
    BIN_DIR="/usr/local/bin"
    PROFILE_DIR="/etc/profile.d"
else
    INSTALL_DIR="${BASH_LIBRARY_PATH:-$HOME/.local/lib/bash-library}"
    BIN_DIR="$HOME/.local/bin"
    PROFILE_DIR="$HOME"
fi

TEMP_DIR=$(mktemp -d)

# Cleanup function
cleanup() {
    rm -rf "$TEMP_DIR"
}

# Trap cleanup on exit
trap cleanup EXIT

# Check for required commands
for cmd in curl git; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: $cmd is required but not installed."
        exit 1
    fi
done

# Create installation directory
echo "Creating installation directory..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/modules"
mkdir -p "$INSTALL_DIR/scripts"
mkdir -p "$BIN_DIR"

# Clone or update the repository
if [ -d "$INSTALL_DIR/.git" ]; then
    echo "Updating existing installation..."
    cd "$INSTALL_DIR"
    git pull
else
    echo "Installing bash library..."
    git clone "$REPO_URL" "$TEMP_DIR"
    cp -r "$TEMP_DIR/modules" "$INSTALL_DIR/"
    cp -r "$TEMP_DIR/scripts" "$INSTALL_DIR/"
    cp "$TEMP_DIR/lib-loader.sh" "$INSTALL_DIR/"
fi

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
if [ "$SYSTEM_INSTALL" = "true" ]; then
    # System-wide installation
    {
        echo "export BASH_LIBRARY_PATH=\"$INSTALL_DIR\""
        echo "export PATH=\"\$PATH:$BIN_DIR\""
        echo "source \"$INSTALL_DIR/lib-loader.sh\""
    } > "$PROFILE_DIR/bash-library.sh"
    chmod 644 "$PROFILE_DIR/bash-library.sh"
else
    # User installation
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
fi

echo "Installation complete!"
if [ "$SYSTEM_INSTALL" = "true" ]; then
    echo "The bash library has been installed system-wide."
    echo "You may need to restart your shell or run: source /etc/profile.d/bash-library.sh"
else
    echo "The bash library is now available in your user space."
    echo "You may need to restart your shell or run: source ~/.bashrc"
fi 