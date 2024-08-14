#!/bin/bash


# Displays the current weather and 5-day forecast in Celsius, using the OpenWeatherMap API.
# You will need to set up your own config file with your API key, location, etc.
# An empty template can be found in the waybar folder in this repository.
# You will also need to install yad, jq, and curl.


source /home/simon/.config/waybar/weather.conf

URL="https://api.openweathermap.org/data/3.0/onecall?lat=${LATITUDE}&lon=${LONGITUDE}&exclude=${EXCLUDE}&units=${UNITS}&appid=${API_KEY}"

RESPONSE=$(curl -s "${URL}")

# Extract and format the specific parts of the JSON response
TIMEZONE=$(echo "${RESPONSE}" | jq -r '.timezone')
CURRENT_DATE=$(echo "${RESPONSE}" | jq -r '.current.dt')
CURRENT_TEMP=$(echo "${RESPONSE}" | jq '.current.temp')
CURRENT_WEATHER=$(echo "${RESPONSE}" | jq -r '.current.weather[0].description')
CURRENT_FEELS_LIKE=$(echo "${RESPONSE}" | jq '.current.feels_like')
CURRENT_PRESSURE=$(echo "${RESPONSE}" | jq '.current.pressure')
CURRENT_HUMIDITY=$(echo "${RESPONSE}" | jq '.current.humidity')
CURRENT_WIND_SPEED=$(echo "${RESPONSE}" | jq '.current.wind_speed')
CURRENT_SUNRISE=$(echo "${RESPONSE}" | jq '.current.sunrise')
CURRENT_SUNSET=$(echo "${RESPONSE}" | jq '.current.sunset')
CURRENT_ICON=$(echo "${RESPONSE}" | jq -r '.current.weather[0].icon')

# Extract daily information
DAILY_TEMPERATURES=$(echo "${RESPONSE}" | jq '.daily[0:5] | map(.temp.day)')
DAILY_MIN_TEMPERATURES=$(echo "${RESPONSE}" | jq '.daily[0:5] | map(.temp.min)')
DAILY_MAX_TEMPERATURES=$(echo "${RESPONSE}" | jq '.daily[0:5] | map(.temp.max)')
DAILY_DESCRIPTIONS=$(echo "${RESPONSE}" | jq -r '.daily[0:5] | map(.weather[0].description)')
DAILY_ICONS=$(echo "${RESPONSE}" | jq -r '.daily[0:5] | map(.weather[0].icon)')

# Convert Unix timestamps to human-readable format
HUMAN_READABLE_DATE=$(date -d @${CURRENT_DATE} +"%a %d-%m-%Y %H:%M")
HUMAN_READABLE_SUNRISE=$(date -d @${CURRENT_SUNRISE} +"%H:%M")
HUMAN_READABLE_SUNSET=$(date -d @${CURRENT_SUNSET} +"%H:%M")

# Format the temperature to one decimal place
CURRENT_TEMP=$(printf "%.1f" "${CURRENT_TEMP}")
CURRENT_FEELS_LIKE=$(printf "%.1f" "${CURRENT_FEELS_LIKE}")

# Map the icon code to the corresponding icon URL
ICON_URL="https://openweathermap.org/img/wn/${CURRENT_ICON}.png"

# Download the icon
ICON_PATH="/tmp/weather_icon.png"
curl -s -o "${ICON_PATH}" "${ICON_URL}"

# Format the daily temperatures and descriptions
DAILY_INFO=""
for i in $(seq 0 4); do
    DAY_TEMP=$(echo "${DAILY_TEMPERATURES}" | jq -r ".[$i]")
    DAY_MIN_TEMP=$(echo "${DAILY_MIN_TEMPERATURES}" | jq -r ".[$i]")
    DAY_MAX_TEMP=$(echo "${DAILY_MAX_TEMPERATURES}" | jq -r ".[$i]")
    DAY_DESC=$(echo "${DAILY_DESCRIPTIONS}" | jq -r ".[$i]")

    # Format temperatures to one decimal place
    DAY_TEMP=$(printf "%.1f" "${DAY_TEMP}")
    DAY_MIN_TEMP=$(printf "%.1f" "${DAY_MIN_TEMP}")
    DAY_MAX_TEMP=$(printf "%.1f" "${DAY_MAX_TEMP}")

    DAILY_INFO="${DAILY_INFO}
Day $((i+1)):
    Temperature: ${DAY_TEMP}°C
    Min: ${DAY_MIN_TEMP}°C
    Max: ${DAY_MAX_TEMP}°C
    Description: ${DAY_DESC}
"
done

# Format the output string
INFO="
Weather Report:
Date: ${HUMAN_READABLE_DATE}
Timezone: ${TIMEZONE}

Current Conditions:
    Temperature: ${CURRENT_TEMP}°C
    Feels Like: ${CURRENT_FEELS_LIKE}°C
    Weather: ${CURRENT_WEATHER}
    Pressure: ${CURRENT_PRESSURE}hPa
    Humidity: ${CURRENT_HUMIDITY}%
    Wind Speed: ${CURRENT_WIND_SPEED}m/s
    Sunrise: ${HUMAN_READABLE_SUNRISE}
    Sunset: ${HUMAN_READABLE_SUNSET}

Daily Forecast:
${DAILY_INFO}
"

# Define the position and size of the yad window
WIDTH=400  # Adjusted width to fit content
HEIGHT=300  # Adjusted height to fit content
POSX=100
POSY=100

# Display the tooltip using yad with specified options
yad --image="${ICON_PATH}" \
    --text="${INFO}" \
    --button=Close:0 \
    --posx=${POSX} \
    --posy=${POSY} \
    --width=${WIDTH} \
    --height=${HEIGHT} \
    --fixed \
    --title="Weather Report" \
    --text-align=left \
    --timeout=30
