#!/usr/bin/bash
# Switches sww wallpaper
# Requires: coreutils, xrandr, hyprland

if [ "$1" == "--noswitch" ]; then
    imgpath=$(swww query | awk -F 'image: ' '{print $2}')
else
    # Select and set image (hyprland)
    cd "$HOME/.wallpapers/"
    imgpath=$(yad --width 1200 --height 800 --file --title='Choose wallpaper')
    screensizey=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2 | head -1)
    cursorposx=$(hyprctl cursorpos -j | gojq '.x')
    cursorposy=$(hyprctl cursorpos -j | gojq '.y')
    cursorposy_inverted=$(( screensizey - cursorposy ))

    if [ "$imgpath" == '' ]; then
        echo 'Aborted'
        exit 0
    fi

    echo Sending "$imgpath" to swww. Cursor pos: ["$cursorposx, $cursorposy_inverted"]
    # Change swww wallpaper
    swww img "$imgpath" --transition-step 100 --transition-fps 60 \
    --transition-type grow --transition-angle 30 --transition-duration 1 \
    --transition-pos "$cursorposx, $cursorposy_inverted"
fi

# Generate colors for ags n stuff
"$HOME"/.config/ags/scripts/color_generation/colorgen.sh "${imgpath}" --apply

wal -q -e -i ${imgpath} 
rm $HOME/.wallpapers/currentWall
ln -s ${imgpath} $HOME/.wallpapers/currentWall
pywal-discord
convert ~/.wallpapers/currentWall -crop 1920x1200+800+500 ~/.config/rofi/bannerImage.jpg

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
