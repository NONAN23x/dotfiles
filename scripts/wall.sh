#!/bin/bash

directory="/home/nonan23x/.wallpapers/"

# Get a random file from the directory
random_file=$(ls "$directory" | shuf -n 1)

rm $directory\ currentWall
ln -s $random_file $directory\ currentWall


# Echo the randomly selected file
swww img $directory$random_file --transition-step 250 --transition-type grow --transition-fps 180 --transition-duration 2 --transition-pos "3000,1800" 
wal -q -i ~/.wallpapers/\ currentWall
pywal-discord
