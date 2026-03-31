# DevOps Shield CLI - Professional Installer (Windows)
# Supports x64

$GITHUB_USER = "SmtTheSE"
$REPO_NAME = "shield-cli"
$BINARY_NAME = "shield.exe"
$INSTALL_DIR = "$HOME\AppData\Local\shield-cli"

# Detect Architecture
$ARCH = "x64" # Default for Windows build
$ASSET_NAME = "shield.exe"

# Create Install Directory
if (!(Test-Path $INSTALL_DIR)) {
    New-Item -ItemType Directory -Force -Path $INSTALL_DIR | Out-Null
}

# Fetch Latest Tag
$RELEASES_URL = "https://api.github.com/repos/$GITHUB_USER/$REPO_NAME/releases/latest"
$LATEST_RELEASE = Invoke-RestMethod -Uri $RELEASES_URL
$LATEST_TAG = $LATEST_RELEASE.tag_name

if (!$LATEST_TAG) {
    Write-Error "Could not fetch latest release. Please ensure the repository is public and contains a release."
    return
}

$DOWNLOAD_URL = "https://github.com/$GITHUB_USER/$REPO_NAME/releases/download/$LATEST_TAG/$ASSET_NAME"

Write-Host "Downloading $BINARY_NAME $LATEST_TAG..."
Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile "$INSTALL_DIR\$BINARY_NAME"

# Update PATH if not already present
$PATH_VAR = [Environment]::GetEnvironmentVariable("Path", "User")
if ($PATH_VAR -notlike "*$INSTALL_DIR*") {
    [Environment]::SetEnvironmentVariable("Path", "$PATH_VAR;$INSTALL_DIR", "User")
    $env:Path = "$env:Path;$INSTALL_DIR"
    Write-Host "✅ Path updated. You may need to restart your terminal."
}

Write-Host "--------------------------------------------------------"
Write-Host "✅ Success! DevOps Shield is now installed."
Write-Host "Type 'shield' to get started."
Write-Host "--------------------------------------------------------"
