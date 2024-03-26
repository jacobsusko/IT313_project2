#!/bin/bash

# Author: May
# This code has been tested

# Define hall and room based on the hall and room combination.
case "$1" in
    "King_357")
        hall="King"
        room="357"
        ;;
    "King_358")
        hall="King"
        room="358"
        ;;
    "EnGeo_2020")
        hall="EnGeo"
        room="2020"
        ;;
    "EnGeo_2037")
        hall="EnGeo"
        room="2037"
        ;;
    "PhysChem_101")
        hall="PhysChem"
        room="101"
        ;;
    "PhysChem_202")
        hall="PhysChem"
        room="202"
        ;;
    # Add more cases for other hall and room combinations as needed
    # Separate these buildings by Raspberry Pi when needed.
    *)
        echo "Unknown hall and room combination: $1"
        exit 1
        ;;
esac

# Construct the path to the occupancy file
occupancy_file="/home/be313/BE/track_occ/occupancy_${hall}_${room}.txt"
# Check if the occupancy file exists
if [ -f "$occupancy_file" ]; then  # If the occupancy_file exists.
    occupancy_value=$(cat "$occupancy_file")    # Then the occumapncy_value will be read from the file specified and sent to the API and website.

# -f flag in the condition checks whether the specified file exists.
# If condition is met and file exists, the occupancy_value is read from the file.
    
    # Check if occupancy_value is set
    if [ -z "$occupancy_value" ]; then # If the occupancy_value is empty.
        echo "Error: occupancy_value not set in the occupancy file for hall $hall and room $room"
        exit 1
    fi

 # -z checks if the variable is empty.

    
    # Send data to the server
    curl -X PUT -H "Content-Type: application/json" -H "apikey: pQrz7Yr3gX" -d "{\"occupancy\": ${occupancy_value}}" https://jmustudyhall.com:7304/room_occupancy/${hall}/${room}
else
    echo "Occupancy file not found for hall $hall and room $room"
    exit 1
fi
