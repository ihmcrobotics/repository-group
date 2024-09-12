# Set Gradle version
$GRADLE_VERSION = "8.10.1"

# Set installation directory
$INSTALL_DIR = "C:\Gradle"

# Download Gradle
Write-Host "Downloading Gradle $GRADLE_VERSION..."
Invoke-WebRequest "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" -OutFile "gradle.zip"

# Create installation directory
if (-Not (Test-Path $INSTALL_DIR)) {
    New-Item -ItemType Directory -Path $INSTALL_DIR
}

# Extract Gradle
Write-Host "Extracting Gradle..."
Expand-Archive -Path "gradle.zip" -DestinationPath $INSTALL_DIR

$GRADLE_HOME = "$INSTALL_DIR\gradle-$GRADLE_VERSION"

# Set GRADLE_HOME environment variable
[Environment]::SetEnvironmentVariable("GRADLE_HOME", "$GRADLE_HOME", [EnvironmentVariableTarget]::Machine)

# Add Gradle to PATH
$env:Path += ";$GRADLE_HOME\bin"
[Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::Machine)

# Clean up
Remove-Item "gradle.zip"

Write-Host "Gradle $GRADLE_VERSION has been installed and added to the system PATH."
Write-Host "Please restart your command prompt for the changes to take effect."
