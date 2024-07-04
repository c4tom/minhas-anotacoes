#!/bin/bash

mkdir -p odysee

ffmpeg -i "$1" -c:v libx264 -crf 23 -c:a aac -b:a 128k -vf "scale=1280:-1" "odysee/$1.mp4"


