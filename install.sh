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
        echo "Error: Intel-based macOS (x64) is currently not supported for direct binary installation on the free tier."
        echo "Please use a Mac with Apple Silicon (M1/M2/M3) or build from source."
        exit 1
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
    echo "Error: Could not fetch latest release. Please ensure the repository is public and contains a release."
    exit 1
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
echo "✅ Success! DevOps Shield is now installed."
echo "Type 'shield' to get started."
echo "--------------------------------------------------------"
