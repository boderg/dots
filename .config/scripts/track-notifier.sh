#!/bin/bash

# Function to send notification
send_notification() {
    local artist=$(playerctl metadata artist)
    local title=$(playerctl metadata title)
    local album=$(playerctl metadata album)
    local art_url=$(playerctl metadata mpris:artUrl)

    notify-send "Now Playing" "$artist - $title\nAlbum: $album" -i "$art_url"
}

# Initial track info
current_track=$(playerctl metadata --format "{{ artist }} - {{ title }}")

# Loop to check for new tracks
while true; do
    new_track=$(playerctl metadata --format "{{ artist }} - {{ title }}")
    
    # Check if new_track is empty
    if [ -z "$new_track" ]; then
        sleep 5
        continue
    fi

    if [ "$new_track" != "$current_track" ]; then
        current_track=$new_track
        send_notification
    fi
    sleep 5
done