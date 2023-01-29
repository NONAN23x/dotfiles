#!/bin/bash
# Single script to automate
# all the manual work

mkdir ~/.fonts
cp -r fonts/* ~/.fonts/
fc-cache -fv
cp -r cava/ ~/.config/
cp -r conky/ ~/.config/
cp -r fish/ ~/.config/
cp -r glava/ ~/.config/
cp -r zathura ~/.config/
cp vimrc ~/.vimrc
cp startship.toml ~/.config/
