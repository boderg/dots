#!/bin/bash

# File to store the current layout
LAYOUT_FILE="/tmp/current_keyboard_layout"

# Function to set the keyboard layout
set_keyboard_layout() {
    layout=$1
    if [ "$layout" == "us" ]; then
        hyprctl keyword input:kb_layout "us"
        echo "Keyboard layout set to US English"
        send_notification "Keyboard layout set to US English"
    elif [ "$layout" == "gb" ]; then
        hyprctl keyword input:kb_layout "gb"
        echo "Keyboard layout set to GB English"
        send_notification "Keyboard layout set to GB English"
    else
        echo "No layout selected"
        send_notification "No layout selected"
    fi
}

# Function to send a notification
send_notification() {
    message=$1
    notify-send -i /home/simon/.config/mako/icons/language-translation-icon.png "Keyboard Layout Switcher" "$message"
}

# Read the current layout from the file
if [ -f "$LAYOUT_FILE" ]; then
    current_layout=$(cat "$LAYOUT_FILE")
else
    current_layout="us"
fi

# Toggle the layout
if [ "$current_layout" == "us" ]; then
    new_layout="gb"
else
    new_layout="us"
fi

# Set the new layout
set_keyboard_layout "$new_layout"

# Save the new layout to the file
echo "$new_layout" > "$LAYOUT_FILE"
