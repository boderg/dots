#!/bin/bash

# Function to set the keyboard layout
set_keyboard_layout() {
    layout=$1
    if [ "$layout" == "us" ]; then
        hyprctl keyword input:kb_layout "us"
        echo "Keyboard layout set to US English"
    elif [ "$layout" == "gb" ]; then
        hyprctl keyword input:kb_layout "gb"
        echo "Keyboard layout set to GB English"
    else
        echo "Invalid layout selected"
    fi
}

# Display selection menu using wofi
selected_layout=$(echo -e "us\ngb" | wofi --dmenu --hide-scroll --height=45 --width=100 --x=1500 --y=20 --prompt="Select Keyboard Layout:")

# Display selection menu using yad
# selected_layout=$(yad --list --radiolist --column="" --column="Layout" TRUE "us" FALSE "gb" --title="Select Keyboard Layout" --width=300 --height=150 --center --button=OK:0 --button=Cancel:1 | awk '{print $2}')


# Trim any leading or trailing spaces
selected_layout=$(echo "$selected_layout" | xargs)

# Set the keyboard layout based on the selection
set_keyboard_layout "$selected_layout"
