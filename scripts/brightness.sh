#!/bin/bash

# max=96000

down() {
mpv ~/.sounds/attaboy_01.ogg &
lightctl down
}

up() {
mpv ~/.sounds/attaboy_01.ogg &
lightctl up
}

case "$1" in
  up) up;;
  down) down;;
esac
