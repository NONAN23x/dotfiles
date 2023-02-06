#!/bin/bash

killall conky
		
conky -c $HOME/.config/conky/Overlay/Overlay.conf &> /dev/null &

exit
