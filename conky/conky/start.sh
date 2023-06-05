#!/bin/bash

killall conky

sleep 2s

conky -c /home/nonan23x/.config/conky/Overlay/Overlay.conf &>/dev/null &

glava -d 
