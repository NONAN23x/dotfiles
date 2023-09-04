#!/bin/bash

max=96000

down() {
brightnessctl set 5%-
volume=$(($(brightnessctl g) * 100 / $max))
[$volume -gt 0 ] && volume=`expr $volume`  
}

up() {
brightnessctl set 5%+
volume=$(($(brightnessctl g) * 100 / $max))
[ $volume -lt 100 ] && volume=`expr $volume`  
}

case "$1" in
  up) up;;
  down) down;;
esac
