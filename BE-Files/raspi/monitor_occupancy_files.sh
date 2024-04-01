#!/bin/bash

# Author: May
# This code has been tested

# Use 'inotifywait'
# This script will monitor changes to the occupancy files and trigger the main >


# Define the directory where occupancy files are located.
occupancy_dir="/home/be313/BE/track_occ/"

# Monitors changes to occupancy files
        while filename=$(inotifywait -e moved_to --format "%f" "$occupancy_dir"); do
              hall_room=$(echo "$filename" | cut -d'.' -f1)
              ./CCscript-main.sh "$hall_room"
        done
# Makes filename the file moved to and parses it into hall_room.
# Uses the parsed file name $hall_room as the argument to be executed with the CCscript-main.sh script.