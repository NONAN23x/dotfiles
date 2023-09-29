#!/bin/bash
mpv --no-video $HOME/.sounds/mixkit-liquid-bubble-3000.wav &
# killall rofi || $HOME/.config/rofi/launcher.sh 
killall rofi || rofi -modi emoji -show drun -theme ~/.config/rofi/style.rasi
