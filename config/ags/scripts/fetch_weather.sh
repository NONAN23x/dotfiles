#!/bin/bash
# fetch_weather.sh

API_KEY="0c993f03599686bea10cfe3a06c127d8"
CITY_ID="1269843"  # Replace with your city ID
API_URL="https://api.openweathermap.org/data/2.5/weather?id=${CITY_ID}&appid=${API_KEY}&units=metric"

# Using curl to fetch the weather data
weather_data=$(curl -s "${API_URL}")

# Parsing the weather data to output desired information
# This example extracts the main weather and temperature
echo $weather_data | jq -r '"\(.weather[0].description), \(.main.temp | round)°C"'

