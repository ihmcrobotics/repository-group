# Set Gradle version
$GRADLE_VERSION = "8.11.1"

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
Expand-Archive -Path "gradle.zip" -DestinationPath $INSTALL_DIR -ErrorAction SilentlyContinue

$GRADLE_HOME = "$INSTALL_DIR\gradle-$GRADLE_VERSION"

# Set GRADLE_HOME environment variable
[Environment]::SetEnvironmentVariable("GRADLE_HOME", "$GRADLE_HOME", [EnvironmentVariableTarget]::Machine)

# Get the current PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)

# Split the PATH into an array
$pathArray = $currentPath -split ";"

# Filter out any entries matching the Gradle\bin pattern (case-insensitive)
$gradleBinRegex = "^.*gradle.*$"
$newPathArray = $pathArray | Where-Object { $_ -notmatch $gradleBinRegex -and $_ -ne "" }

# Join the array back into a string
$newPath = $newPathArray -join ";"

# Add the new Gradle\bin directory
$newPath += ";$GRADLE_HOME\bin"

# Set the new PATH
[Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::Machine)

# Optionally, update the current session's PATH
$env:Path = $newPath

# Clean up
Remove-Item "gradle.zip"

Write-Host "Gradle $GRADLE_VERSION has been installed and added to the system PATH."
Write-Host "Please restart your command prompt for the changes to take effect."
