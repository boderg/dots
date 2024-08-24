#!/bin/bash

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
    notify-send -i /home/simon/.config/waybar/icons/language-translation-icon.png "Keyboard Layout Switcher" "$message"
}

# Display selection menu using wofi
selected_layout=$(echo -e "US English\nGB English" | \
wofi \
--conf=/home/simon/.config/wofi/keyboard/config \
--dmenu \
--height=80 \
--width=200)

# Trim any leading or trailing spaces
selected_layout=$(echo "$selected_layout" | xargs)

# Map the selected full name to the corresponding layout code
case "$selected_layout" in
    "US English")
        layout_code="us"
        ;;
    "GB English")
        layout_code="gb"
        ;;
    *)
        layout_code=""
        ;;
esac

# Set the keyboard layout based on the selection
set_keyboard_layout "$layout_code"
