#!/bin/bash

# Points to where the wallpapers are stored
directory="$HOME/.wallpapers/"

# Get the current wallpaper file
current_wallpaper=$(readlink "$directory"currentWall)

# List of all wallpaper files in the directory
wallpapers=("$directory"*)

# Sort the wallpapers alphabetically
IFS=$'\n' sorted_wallpapers=($(sort <<<"${wallpapers[*]}"))
unset IFS

# Find the index of the current wallpaper in the sorted list
for index in "${!sorted_wallpapers[@]}"; do
    if [[ "${sorted_wallpapers[index]}" == "$current_wallpaper" ]]; then
        current_index=$index
        break
    fi
done

# Calculate the next index
next_index=$(( (current_index + 1) % ${#sorted_wallpapers[@]} ))

# Get the next wallpaper file
next_wallpaper="${sorted_wallpapers[next_index]}"

# Update the symbolic link to the next wallpaper
rm "$directory"currentWall
ln -s "$next_wallpaper" "$directory"currentWall

# Apply the next wallpaper
swww img "$next_wallpaper" --transition-step 150 --transition-type grow --transition-fps 180 --transition-duration 2 --transition-pos "2500,150"

# trigger pywal for terminal color scheme
wal -q -i ~/.wallpapers/currentWall

# triggeer pywal for discord theme
pywal-discord

# material you colour scheme for gtk applications
gradience-cli monet -n "Material You" -p "/home/nonan23x/.wallpapers/currentWall" --theme dark
gradience-cli apply -n "Material You"
gradience-cli flatpak-overrides -e both
