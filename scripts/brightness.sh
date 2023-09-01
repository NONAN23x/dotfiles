#!/bin/bash

max=96000

down() {
brightnessctl set 5%-
volume=$(($(brightnessctl g) * 100 / $max))
[$volume -gt 0 ] && volume=`expr $volume`  
# dunstify -a "Brightness" "Decreasing to $volume%" -h int:value:"$volume" -i audio-volume-low-symbolic -r 2593 -u normal
canberra-gtk-play -i dialog-error -d "error"
}

up() {
brightnessctl set 5%+
volume=$(($(brightnessctl g) * 100 / $max))
[ $volume -lt 100 ] && volume=`expr $volume`  
# dunstify -a "Brightness" "Increasing to $volume%" -h int:value:"$volume" -i audio-volume-high-symbolic -r 2593 -u normal
canberra-gtk-play -i dialog-error -d "error"
}

case "$1" in
  up) up;;
  down) down;;
esac
