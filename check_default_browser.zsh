#!/bin/zsh

# Get the default web browser
default_browser=$(defaults read com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers | grep -B 1 -E 'LSHandlerURLScheme = https?;' | awk '/LSHandlerRoleAll/ {print $NF}' | tr -d \; | tr -d \")

# Check if Google Chrome is the default browser
if [[ $default_browser == "com.google.chrome" ]]; then
    echo "Google Chrome is the default browser."
else
    echo "Google Chrome is NOT the default browser. Current default is: $default_browser"
fi