#!/bin/bash

killall conky
sleep 2s
		
conky -c $HOME/.config/conky/Mirach/Mirach.conf &> /dev/null &

exit
