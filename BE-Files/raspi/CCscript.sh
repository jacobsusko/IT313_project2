#!/bin/bash
#This code has not been tested
# Get the IP address of the ESP32 board
esp32_ip=$(curl -s http://<ESP32_IP_ADDRESS>/get_ip)

# Define hall and room based on the IP address
case "$esp32_ip" in
    "192.168.25.3")
        hall="King"
        room="357"
        ;;
    "192.168.25.4")
        hall="King"
        room="358"
        ;;
    "192.168.1.101")
        hall="EnGeo"
        room="2020"
        ;;
    "192.168.1.101")
        hall="EnGeo"
        room="2037"
        ;;
    "192.168.1.101")
        hall="Phys/Chem"
        room="101"
        ;;
    "192.168.1.101")
        hall="Phys/Chem"
        room="202"
        ;;
    # Add more cases as needed for other ESP32 IP addresses
    *)
        echo "Unknown ESP32 IP address: $esp32_ip"
        exit 1
        ;;
esac

# Read the occupancy value from the file on Raspberry Pi
occupancy_file="/path/to/occupancy_file.txt"
occupancy_value=$(cat "$occupancy_file")

# Send data to the server
curl -X PUT -H "Content-Type: application/json" -H "apikey: pQrz7Yr3gX" -d "{\"occupancy\": ${occupancy_value}}" http://3.128.186.180:7304/room_occupancy/${hall}/${room}
