#!/bin/bash
user=$(whoami)
mpv --no-video --volume=100 ~/Music/ubuntu_startup_sound.mp3
sleep 5
notify-send -u normal -t 8000 "Welcome back $user"
