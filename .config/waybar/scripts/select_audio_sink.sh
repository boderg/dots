#!/bin/bash


# A script to select an audio sink and set it as the default sink using wofi


# Get the current default sink
current_sink=$(pactl info | grep "Default Sink" | awk '{print $3}')

# List all audio sinks with their friendly names
sinks=$(pactl list short sinks | while read -r line; do
  sink_name=$(echo "$line" | awk '{print $2}')
  sink_description=$(pactl list sinks | grep -A 10 "Name: $sink_name" | grep "Description:" | sed 's/.*Description: //')
  if [ "$sink_name" == "$current_sink" ]; then
    sink_description="==> $sink_description <=="
  fi
  echo "$sink_name|$sink_description"
done)

# Display sinks in wofi and get the selected sink description
selected_description=$(echo "$sinks" | awk -F'|' '{print $2}' | wofi --dmenu --hide-scroll --height=108 --width=650 --x=1246 --y=20)

# Display sinks in yad and get the selected sink description
# selected_description=$(echo "$sinks" | awk -F'|' '{print $2}' | yad --list --column="Description" --hide-column=1 --width=650 --height=400 --title="Select Audio Sink" --button="Select:0" --button="Cancel:1" --print-column=2 | xargs)

# Trim whitespace from the selected description
selected_description=$(echo "$selected_description" | xargs)

# Escape special characters in the selected description for grep
escaped_description=$(echo "$selected_description" | sed 's/[]\/$*.^|[]/\\&/g')

# Find the sink name corresponding to the selected description
selected_sink=$(echo "$sinks" | grep "|$escaped_description" | awk -F'|' '{print $1}')

# Check if the selected sink is valid
if [ -z "$selected_sink" ]; then
  notify-send "No sink selected or invalid selection"
  exit 1
fi

# Set the selected sink as the default if it is different from the current sink
if [ "$selected_sink" != "$current_sink" ]; then
  if pactl set-default-sink "$selected_sink"; then

    # Move all playing audio streams to the new sink
    for stream in $(pactl list short sink-inputs | awk '{print $1}'); do
      pactl move-sink-input "$stream" "$selected_sink"
    done

    notify-send "Audio output changed to $selected_description"
  else
    notify-send "No audio output selected"
  fi
else
  notify-send "Audio output is already set to $selected_description"
fi