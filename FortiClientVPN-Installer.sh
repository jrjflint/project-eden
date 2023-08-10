#!/bin/bash

# Define the log file path
LOG_FILE="/var/log/forticlient_install.log"

# Function to log messages
log_message() {
    echo "$(date): $1" >> "$LOG_FILE"
}

# Check if the script is running as root
if [ "$(id -u)" -ne 0 ]; then
    log_message "The script must be run as root. Exiting."
    exit 1
fi

# Download the FortiClient VPN dmg file
log_message "Starting to download FortiClient VPN..."
curl -o /tmp/FortiClient.dmg "https://link_to_forticlient_vpn.dmg"
if [ $? -ne 0 ]; then
    log_message "Error downloading FortiClient VPN. Exiting."
    exit 1
else
    log_message "Successfully downloaded FortiClient VPN."
fi

# Mount the dmg file
hdiutil attach /tmp/FortiClient.dmg
if [ $? -ne 0 ]; then
    log_message "Error mounting FortiClient.dmg. Exiting."
    exit 1
else
    log_message "Successfully mounted FortiClient.dmg."
fi

# Install the FortiClient VPN
sudo installer -pkg /Volumes/FortiClient/FortiClient.pkg -target /
if [ $? -ne 0 ]; then
    log_message "Error installing FortiClient VPN. Exiting."
    exit 1
else
    log_message "Successfully installed FortiClient VPN."
fi

# Unmount the dmg file
hdiutil detach /Volumes/FortiClient
if [ $? -ne 0 ]; then
    log_message "Error unmounting FortiClient.dmg. Exiting."
    exit 1
else
    log_message "Successfully unmounted FortiClient.dmg."
fi

# Clean up
rm -f /tmp/FortiClient.dmg
log_message "Installation process completed."

exit 0
