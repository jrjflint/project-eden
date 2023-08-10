#!/bin/bash

# Set the log file path
LOG_FILE="/var/log/sophos_install.log"

# Function to log messages
log_msg() {
    echo "$(date) - $1" >> "$LOG_FILE"
}

# Download the zip file
curl -O http://path_to_your_file/SophosInstall.zip

# Check if the download was successful
if [[ $? -ne 0 ]]; then
    log_msg "ERROR: Failed to download SophosInstall.zip"
    exit 1
else
    log_msg "SophosInstall.zip downloaded successfully."
fi

# Extract the zip file
unzip SophosInstall.zip

# Check if unzip was successful
if [[ $? -ne 0 ]]; then
    log_msg "ERROR: Failed to extract SophosInstall.zip"
    exit 1
else
    log_msg "SophosInstall.zip extracted successfully."
fi

# Add the profile
sudo profiles -I -F "Deployment Tools/Sophos Endpoint Vntura v1.2.mobileconfig"

# Check if profile addition was successful
if [[ $? -ne 0 ]]; then
    log_msg "ERROR: Failed to add Sophos Endpoint Vntura v1.2.mobileconfig profile"
    exit 1
else
    log_msg "Sophos Endpoint Vntura v1.2.mobileconfig profile added successfully."
fi

# Install the Sophos Installer.app (assuming it's a drag and drop installation to the Applications folder)
cp -R "Sophos Installer.app" /Applications/

# Check if the installation was successful
if [[ $? -ne 0 ]]; then
    log_msg "ERROR: Failed to install Sophos Installer.app"
    exit 1
else
    log_msg "Sophos Installer.app installed successfully."
fi

# All done
exit 0
