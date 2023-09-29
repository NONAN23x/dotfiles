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
swww img "$next_wallpaper" --transition-step 150 --transition-type any --transition-fps 180 --transition-duration 2 

# trigger pywal for terminal color scheme
wal -q -i ~/.wallpapers/currentWall -p "Material_You"

# triggeer pywal for discord theme
pywal-discord

# material you colour scheme for gtk applications
gradience-cli monet -n "Material_You" -p "/home/nonan23x/.wallpapers/currentWall" --theme dark
gradience-cli apply -n "Material_You"
# gradience-cli flatpak-overrides -e both

# generate colors for borders
dominantCol=$(jq '.colors.color4' $HOME/.config/wal/colorschemes/dark/Material_You.json)
active_border_color=$(echo "$dominantCol" | tr -d '"#')
sed -i "s/col.active_border = .*/col.active_border = rgb($active_border_color)/" /home/nonan23x/.config/hypr/colors.conf


# change cava colors
# Read the colors from lines 10 and 11 of colors.txt

color10=$(sed -n '10p' ~/.cache/wal/colors)
color11=$(sed -n '11p' ~/.cache/wal/colors)

color10="\"$color10\""
color11="\"$color11\""

# Check if the destination file already exists
if [ -e $2 ]; then
  # Create a temporary file for the updated content
  temp_destination="temp_destination.txt"

  # Copy the destination file to the temporary file
  cp ~/.config/cava/config "$temp_destination"

  # Update the lines with gradient colors in the temporary file
  sed -i "s/^gradient_color_1\s*=.*/gradient_color_1 = $color10/" "$temp_destination"
  sed -i "s/^gradient_color_2\s*=.*/gradient_color_2 = $color11/" "$temp_destination"

  # Replace the original destination file with the temporary file
  mv "$temp_destination" ~/.config/cava/config
else
  # If the destination file doesn't exist, create it with the gradient colors
  echo "gradient_color_1 = $color10" > ~/.config/cava/config
  echo "gradient_color_2 = $color11" >> ~/.config/cava/config
fi

# Generate a low res banner image for rofi
convert ~/.wallpapers/currentWall -crop 1920x1200+800+500 ~/.config/rofi/bannerImage.jpg
