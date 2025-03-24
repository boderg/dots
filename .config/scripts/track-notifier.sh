#!/bin/bash

# Function to send notification
send_notification() {
    local artist=$(playerctl metadata artist)
    local title=$(playerctl metadata title)
    local album=$(playerctl metadata album)
    local art_url=$(playerctl metadata mpris:artUrl)
    local timeout=5000

    # notify-send "Now Playing" "$artist - $title\nAlbum: $album" -i "$art_url"
    notify-send -t "$timeout" "Now Playing" "$artist\n$title" -i "$art_url"
}

# Initial track info
current_track=""

# Loop to check for new tracks
while true; do
    # Check if any player is running
    if ! playerctl -l &> /dev/null; then
        sleep 3
        continue
    fi

    # Check if any player is currently playing
    playing_player=$(playerctl -l | while read -r player; do
        if [ "$(playerctl -p "$player" status 2>/dev/null)" = "Playing" ]; then
            echo "$player"
            break
        fi
    done)

    # Skip if no player is actively playing
    if [ -z "$playing_player" ]; then
        sleep 3
        continue
    fi

    # Fetch current track from the active player
    new_track=$(playerctl -p "$playing_player" metadata --format "{{ artist }} - {{ title }}" 2>/dev/null)



    
    # Check if new_track is empty
    if [ -z "$new_track" ]; then
        sleep 3
        continue
    fi

    if [ "$new_track" != "$current_track" ]; then
        current_track=$new_track
        send_notification
    fi
    sleep 3
done
