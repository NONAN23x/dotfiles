#!/bin/bash

killall conky

sleep 2s

conky -c /home/nonan23x/.config/conky/Overlay/Overlay.conf &>/dev/null &

sleep 1s

conky -c /home/nonan23x/.config/conky/Quotes/Quotes.conf &>/dev/null &
