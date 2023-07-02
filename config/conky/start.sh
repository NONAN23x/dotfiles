#!/bin/bash

sleep 3s

killall conky
killall glava

sleep 3s

conky -c /home/nonan23x/.config/conky/Overlay/Overlay.conf &>/dev/null &

glava -d 

