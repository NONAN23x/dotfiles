#!/bin/bash

# Define the path to your config file
CONFIG_FILE="$HOME/.config/hypr/blur.conf"

# Check if argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [on|off]"
    exit 1
fi

# Check the argument and update the config file accordingly
if [ "$1" == "on" ]; then
    sed -i 's/windowrule = opacity 1.0 override 1.0 override/windowrule = opacity 0.9 override 0.9 override/' "$CONFIG_FILE"
    sed -i 's/enabled = false/enabled = true/' "$CONFIG_FILE"
elif [ "$1" == "off" ]; then
    sed -i 's/windowrule = opacity 0.9 override 0.9 override/windowrule = opacity 1.0 override 1.0 override/' "$CONFIG_FILE"
    sed -i 's/enabled = true/enabled = false/' "$CONFIG_FILE"
else
    echo "Invalid argument. Usage: $0 [on|off]"
    exit 1
fi

echo "Settings updated."

