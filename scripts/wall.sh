#!/bin/bash

directory="/home/nonan23x/.wallpapers/"

# Get a random file from the directory
random_file=$(ls "$directory" | shuf -n 1)


# Echo the randomly selected file
swww img $directory$random_file --transition-type any --transition-duration 2 --transition-fps=60

