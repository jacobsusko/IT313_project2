#!/bin/bash

# Author: May
# This code has not been tested

# Use 'inotifywait'
# This script will monitor changes to the occupancy files and trigger the main >


# Define the directory where occupancy files are located.
occupancy_dir="/home/be313/BE/track_occ/"

# Monitors changes to occupancy files
        while inotifywait -e moved_to /home/be313/BE/track_occ; do
        #       hall_room = $(King_357.txt | cut -d"_" -f1,2 | cut -d"." -f1)
        #       ./CCscript-main.sh "$hall_room"
                ./CCscript-main.sh King_357
        done
