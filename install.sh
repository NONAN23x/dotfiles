#!/bin/bash
  
# creating a backup of your previous config files
cp -r ~/.config/ ~/.config_backup/
echo "Backup created at ~/.config_backup"

# copying config files over to home directory
cp -r $(pwd)/config/* ~/.config/
echo "Installed dotfiles to config"

# copying scripts to home direcotry
mkdir -p ~/.scripts/
cp -r $(pwd)/scripts/* ~/.scripts/
echo "Installed necessary scripts"

# copying wallpapers to home directory
mkdir -p ~/.wallpapers/
cp -r $(pwd)/wallpapers/* ~/.wallpapers/
echo "Installed some wallpapers"
