#!/bin/bash

# This script is to get weather data from openweathermap.com in the form of a json file
# so that conky will still display the weather when offline even though it doesn't up to date

# you can use this or replace with yours
api_key=0c993f03599686bea10cfe3a06c127d8
# get your city id at https://openweathermap.org/find and replace

url='http://api.openweathermap.org/data/2.5/weather?q=Hyderabad,in&APPID=0c993f03599686bea10cfe3a06c127d8&cnt=5&units=metric&lang=en'

curl ${url} -s -o ~/.cache/weather.json

data=$(cat ~/.cache/weather.json)
description=$(echo "$data" | jq -r '.weather[0].description')
temp=$(echo "$data" | jq -r '.main.temp | round')



capitalized_description=$(echo "${description^}")
iconifiedtemp=$(echo "$temp°C")
echo "$capitalized_description | $iconifiedtemp"

