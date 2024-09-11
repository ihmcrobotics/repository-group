@echo off
setlocal enabledelayedexpansion

:: Set Gradle version
set GRADLE_VERSION=8.10.1

:: Set installation directory
set INSTALL_DIR=C:\Gradle

:: Download Gradle
echo Downloading Gradle %GRADLE_VERSION%...
powershell -Command "Invoke-WebRequest https://services.gradle.org/distributions/gradle-%GRADLE_VERSION%-bin.zip -OutFile gradle.zip"

:: Create installation directory
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

:: Extract Gradle
echo Extracting Gradle...
powershell -Command "Expand-Archive gradle.zip -DestinationPath %INSTALL_DIR%"

:: Rename extracted folder
ren "%INSTALL_DIR%\gradle-%GRADLE_VERSION%" gradle-%GRADLE_VERSION%

:: Set GRADLE_HOME environment variable
setx GRADLE_HOME "%INSTALL_DIR%\gradle-%GRADLE_VERSION%" /M

:: Add Gradle to PATH
powershell -Command "[System.Environment]::SetEnvironmentVariable('Path', $env:Path + ';%GRADLE_HOME%\bin', [System.EnvironmentVariableTarget]::Machine)"

:: Clean up
del gradle.zip

echo Gradle %GRADLE_VERSION% has been installed and added to the system PATH.
echo Please restart your command prompt for the changes to take effect.

endlocal
