#!/bin/sh

local_dir=$(pwd)
original_filepath="$local_dir/$1"
desktop="/home/can/Área de Trabalho"

ln -sf "$original_filepath" "$desktop/$1"
