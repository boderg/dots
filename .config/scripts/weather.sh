#!/bin/bash

source /home/simon/.config/weather.conf

URL="https://api.openweathermap.org/data/3.0/onecall?lat=${LATITUDE}&lon=${LONGITUDE}&exclude=${EXCLUDE}&units=${UNITS}&appid=${API_KEY}"

RESPONSE=$(curl -s "${URL}")

# Extract and format the specific parts of the JSON response
CURRENT_TEMP=$(echo "${RESPONSE}" | jq '.current.temp')
CURRENT_WEATHER=$(echo "${RESPONSE}" | jq -r '.current.weather[0].main')
CURRENT_ICON=$(echo "${RESPONSE}" | jq -r '.current.weather[0].icon')

# Format the temperature to one decimal place
CURRENT_TEMP=$(printf "%.1f" "${CURRENT_TEMP}")

# Map the icon code to a corresponding Font Awesome icon
case $CURRENT_ICON in
    "01d") ICON="<span font-size='xx-large'></span>" ;;  # Clear sky day
    "01n") ICON="<span font-size='xx-large'></span>" ;;  # Clear sky night
    "02d") ICON="<span font-size='xx-large'></span>" ;;  # Few clouds day
    "02n") ICON="<span font-size='xx-large'></span>" ;;  # Few clouds night
    "03d") ICON="<span font-size='xx-large'></span>" ;;  # Scattered clouds day (substituted with Few clouds day)
    "03n") ICON="<span font-size='xx-large'></span>" ;;  # Scattered clouds night (substituted with Few clouds night)
    "04d") ICON="<span font-size='xx-large'></span>" ;;  # Broken clouds day
    "04n") ICON="<span font-size='xx-large'></span>" ;;  # Broken clouds night
    "09d") ICON="<span font-size='xx-large'></span>" ;;  # Shower rain day
    "09n") ICON="<span font-size='xx-large'></span>" ;;  # Shower rain night
    "10d") ICON="<span font-size='xx-large'></span>" ;;  # Rain day
    "10n") ICON="<span font-size='xx-large'></span>" ;;  # Rain night
    "11d") ICON="<span font-size='xx-large'></span>" ;;  # Thunderstorm day
    "11n") ICON="<span font-size='xx-large'></span>" ;;  # Thunderstorm night
    "13d") ICON="<span font-size='xx-large'></span>" ;;  # Snow day
    "13n") ICON="<span font-size='xx-large'></span>" ;;  # Snow night
    "50d") ICON="<span font-size='xx-large'></span>" ;;  # Mist day
    "50n") ICON="<span font-size='xx-large'></span>" ;;  # Mist night
    *) ICON="<span font-size='xx-large'></span>" ;;  # Default icon for unknown conditions
esac

# Format the output string for Waybar
SUMMARY="${ICON} ${CURRENT_TEMP}°C ${CURRENT_WEATHER}"

# Output the summary for Waybar
printf "${SUMMARY}"