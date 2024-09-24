#!/bin/bash

# Set Gradle version
GRADLE_VERSION="8.10.2"

# Set installation directory
INSTALL_DIR="/opt/gradle"

# Update package list and install required packages
sudo apt update
sudo apt install -y wget unzip

# Download Gradle
echo "Downloading Gradle ${GRADLE_VERSION}..."
wget "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -P /tmp

# Create installation directory
sudo mkdir -p $INSTALL_DIR

# Extract Gradle
echo "Extracting Gradle..."
sudo unzip -d $INSTALL_DIR /tmp/gradle-${GRADLE_VERSION}-bin.zip

# Create symbolic link
rm -rf "${INSTALL_DIR}/latest"
sudo ln -s "${INSTALL_DIR}/gradle-${GRADLE_VERSION}" "${INSTALL_DIR}/latest"

rm /usr/bin/gradle
ln -s "${INSTALL_DIR}/latest/bin/gradle" /usr/bin/gradle

# Clean up
rm /tmp/gradle-${GRADLE_VERSION}-bin.zip

echo "Gradle ${GRADLE_VERSION} has been installed."
