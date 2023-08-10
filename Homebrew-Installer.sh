#!/bin/bash

# Define the log file
LOG_FILE="./log/homebrew_install.log"

# Function to log messages
log_message() {
    echo "$1" | tee -a "$LOG_FILE"
}

if [ -d "./log" ]; then
    log_message "log folder already exists"
else
    mkdir ./log
    log_message "log folder created"
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    log_message "Installing Homebrew..."

    # Install Homebrew
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &> "$LOG_FILE"; then
        log_message "Homebrew successfully installed!"
    else
        log_message "Failed to install Homebrew. Check $LOG_FILE for more details."
        exit 1
    fi
else
    log_message "Homebrew is already installed!"
fi

# Packages to be installed
packages=(
    "1password"
    "adobe-creative-cloud"
    "adobe-acrobat-pro"
    "google-chrome"
    "logmein-client"
    "microsoft-auto-update"
    "intune-company-portal"
    "microsoft-office-businesspro"
    "zoom"
)

# Install the packages
for package in "${packages[@]}"; do
    log_message "Installing $package..."
    brew list "$package" || brew install cask "$package"
    if brew install --cask "$package" &> "$LOG_FILE"; then
        log_message "$package successfully installed!"
    else
        log_message "Failed to install $package. Check $LOG_FILE for more details."
    fi
done

log_message "Installation process completed. Check $LOG_FILE for full details."
