#!/bin/sh

cp -f "$1" "/tmp/$1"
cd /tmp
gunzip "$1"

htmlfile=$(echo "$1" | sed 's/\.gz//')

xdg-open $htmlfile
