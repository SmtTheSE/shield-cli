# DevOps Shield CLI - Professional Installer (Windows)
# Downloads the shield.exe binary and adds it to the user's path

$ErrorActionPreference = 'Stop'

# ==============================================================================
# Configuration
# ==============================================================================
$GITHUB_USER = "SmtTheSE"
$REPO_NAME   = "shield-cli"
$BINARY_NAME = "shield.exe"
$INSTALL_DIR = "$HOME\.devops-shield"

# ==============================================================================
# Fetch Latest Release
# ==============================================================================
Write-Host "Fetching latest release information..."
$releases = Invoke-RestMethod -Uri "https://api.github.com/repos/$GITHUB_USER/$REPO_NAME/releases/latest"
$tag = $releases.tag_name

if ($tag -eq $null -or $tag -eq "") {
    $tag = "v0.1.1"
}

if (-not $tag) {
    Write-Error "Could not fetch latest release. Please ensure the repository is public and contains a release."
    exit 1
}

$downloadUrl = "https://github.com/$GITHUB_USER/$REPO_NAME/releases/download/$tag/shield.exe"

# ==============================================================================
# Installation Process
# ==============================================================================
if (-not (Test-Path $INSTALL_DIR)) {
    New-Item -ItemType Directory -Path $INSTALL_DIR | Out-Null
}

Write-Host "Downloading DevOps Shield $tag..."
Invoke-WebRequest -Uri $downloadUrl -OutFile "$INSTALL_DIR\$BINARY_NAME"

# Add to User PATH if not already there
$path = [Environment]::GetEnvironmentVariable("Path", "User")
if ($path -notlike "*$INSTALL_DIR*") {
    Write-Host "Adding $INSTALL_DIR to User PATH..."
    [Environment]::SetEnvironmentVariable("Path", "$path;$INSTALL_DIR", "User")
    $env:Path += ";$INSTALL_DIR"
}

Write-Host "--------------------------------------------------------"
Write-Host "Success! DevOps Shield is now installed."
Write-Host "Please RESTART your terminal (PowerShell/CMD) to use 'shield'."
Write-Host "--------------------------------------------------------"
