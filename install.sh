#!/bin/bash

# DevOps Shield CLI - Professional Installer (macOS / Linux)
# Supports x64 and ARM64 (Apple Silicon)

set -e

# ==============================================================================
# Configuration
# ==============================================================================
GITHUB_USER="SmtTheSE"
REPO_NAME="shield-cli"
BINARY_NAME="shield"
INSTALL_DIR="/usr/local/bin"

# ==============================================================================
# OS & Architecture Detection
# ==============================================================================
OS_TYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH_TYPE=$(uname -m)

if [[ "$OS_TYPE" == "darwin" ]]; then
    if [[ "$ARCH_TYPE" == "arm64" ]]; then
        ASSET_EXT="macos-arm64"
    else
        ASSET_EXT="macos-x64"
    fi
elif [[ "$OS_TYPE" == "linux" ]]; then
    ASSET_EXT="linux"
else
    echo "Error: This installer only supports macOS and Linux."
    exit 1
fi

echo "System detected: $OS_TYPE ($ARCH_TYPE)"

# ==============================================================================
# Fetch Latest Release
# ==============================================================================
LATEST_TAG=$(curl -s "https://api.github.com/repos/$GITHUB_USER/$REPO_NAME/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$LATEST_TAG" ]; then
    echo "Warning: Could not fetch latest release tag. Defaulting to 'v1.0.5'..."
    LATEST_TAG="v1.1.2"
fi

DOWNLOAD_URL="https://github.com/$GITHUB_USER/$REPO_NAME/releases/download/$LATEST_TAG/shield-$ASSET_EXT"

# ==============================================================================
# Installation Process
# ==============================================================================
echo "Downloading $BINARY_NAME $LATEST_TAG for $ASSET_EXT..."
curl -L -o "$BINARY_NAME" "$DOWNLOAD_URL"
chmod +x "$BINARY_NAME"

echo "Installing to $INSTALL_DIR..."
if [ -w "$INSTALL_DIR" ]; then
    mv "$BINARY_NAME" "$INSTALL_DIR/shield"
else
    sudo mv "$BINARY_NAME" "$INSTALL_DIR/shield"
fi

echo "--------------------------------------------------------"
echo " Success! DevOps Shield is now installed."
echo "Type 'shield' to get started."
echo "--------------------------------------------------------"
