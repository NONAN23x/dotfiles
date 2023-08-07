#!/bin/bash

killall waybar
sleep 1
waybar -s ~/.config/waybar/topbar/style.css -c ~/.config/waybar/topbar/config.jsonc &
sleep 1
waybar -s ~/.config/waybar/bottombar/style.css -c ~/.config/waybar/bottombar/config.jsonc &

