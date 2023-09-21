#!/bin/bash
mpv --no-video --volume=100 $HOME/.sounds/check-off.wav &
# killall rofi || $HOME/.config/rofi/launcher.sh 
killall rofi || rofi -modi emoji -show drun -theme ~/.config/rofi/style.rasi
