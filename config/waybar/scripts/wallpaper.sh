#!/bin/python

import sys
import os
import random

paper = "/home/nonan23x/Pictures/walls/"
wallpaper = random.choice(os.listdir(paper))

path = os.path.join("~/Pictures/walls/", wallpaper)

print(f"swww img {path}")

os.system(f"swww img {path} --transition-type any --transition-fps 90 --transition-duration 2")
