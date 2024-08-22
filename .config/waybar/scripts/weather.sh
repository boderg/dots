#!/bin/bash

source /home/simon/.config/waybar/weather.conf

URL="https://api.openweathermap.org/data/3.0/onecall?lat=${LATITUDE}&lon=${LONGITUDE}&exclude=${EXCLUDE}&units=${UNITS}&appid=${API_KEY}"

RESPONSE=$(curl -s "${URL}")

# Extract and format the specific parts of the JSON response
CURRENT_TEMP=$(echo "${RESPONSE}" | jq '.current.temp')
CURRENT_WEATHER=$(echo "${RESPONSE}" | jq -r '.current.weather[0].main')
CURRENT_ICON=$(echo "${RESPONSE}" | jq -r '.current.weather[0].icon')

# Format the temperature to one decimal place
CURRENT_TEMP=$(printf "%.1f" "${CURRENT_TEMP}")

# Map the icon code to a corresponding Unicode or Font Awesome icon
case $CURRENT_ICON in
    "01d") ICON="" ;;  # Clear sky day
    "01n") ICON="" ;;  # Clear sky night
    "02d") ICON="" ;;  # Few clouds day
    "02n") ICON="" ;;  # Few clouds night
    "03d" | "03n") ICON="" ;;  # Scattered clouds
    "04d" | "04n") ICON="" ;;  # Broken clouds
    "09d" | "09n") ICON="" ;;  # Shower rain
    "10d") ICON="" ;;  # Rain day
    "10n") ICON="" ;;  # Rain night
    "11d" | "11n") ICON="" ;;  # Thunderstorm
    "13d" | "13n") ICON="" ;;  # Snow
    "50d" | "50n") ICON="" ;;  # Mist
    *) ICON="" ;;  # Default icon for unknown conditions
esac

# Format the output string for Waybar
SUMMARY="${ICON} ${CURRENT_TEMP}°C ${CURRENT_WEATHER}"

# Output the summary for Waybar
echo "${SUMMARY}"