#!/bin/bash

# Function to display the available sinks and their descriptions
function display_sinks() {
    pacmd list-sinks | grep -E 'device.description|index:|name:' | awk '/device.description.*Speaker/{print "\033[0;91m"$0"\033[0m"; next} {print}'
}

# Function to set the default sink based on user input
function set_default_sink() {
    read -p "Enter the index of the sink you want to set as the default: " index
    pacmd set-default-sink $index
    echo "Sink with index $index has been set as the default."
}

# Main script execution
display_sinks
set_default_sink
