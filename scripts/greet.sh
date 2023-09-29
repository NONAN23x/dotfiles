#!/bin/bash
user=$(whoami)
mpv --no-video $HOME/.sounds/ubuntu_startup_sound.mp3
sleep 5
notify-send -u normal -t 8000 "Welcome back $user"
