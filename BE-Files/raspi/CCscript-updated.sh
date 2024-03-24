
#!/bin/bash

# Author: May
# This code has not been tested

# Get the IP address of the ESP32 board
esp32_ip=$(curl -s http://<ESP32_IP_ADDRESS>/get_ip)

# Breakdown of curl command
# curl is the command-line tool used to transfer the data to the server.
# -s is used to put the command in silent mode since the output of IP is unnecessary.
# http://<ESP32_IP_ADDRESS>/get_ip is the url where the command is sending a GET request.
# esp32_ip=$(...) is where the output from the curl is going to be stored.
# esp32_ip=$(...) is used in the next part of the script.


# Define hall and room based on the IP address
# First two cases are real IPs that we will be using.
# The rest are filler IPs, but correct hall and room values.
# esp32_ip=$(...) is used in this part of the script and containst the IP addresses of the esp32s.

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

# Read the occupancy value from the respective file on Raspberry Pi
occupancy_file="/path/to/occupancy_${hall}_${room}.txt" 
if [ -f "$occupancy_file" ]; then   # If the file exists and is a regular .txt file, 
    occupancy_value=$(cat "$occupancy_file")    # Then the occumapncy_value will be read from the file specified and sent to the API and website.
else
    echo "Occupancy file not found for hall $hall room $room"  # If file does not exist, message is sent.
    exit 1
fi




# -f flag in the condition checks whether the specified file exists.
# If condition is met and file exists, the occupancy_value is read from the file.


# Send data to the server
curl -X PUT -H "Content-Type: application/json" -H "apikey: pQrz7Yr3gX" -d "{\"occupancy\": ${occupancy_value}}" https://3.128.186.180:7304/room_occupancy/${hall}/${room}

# curl is the command-line tool used to transfer the data to the server.
# -X PUT is the request method used. PUT is used to update the server in this case.
# -H "Content-Type: application/json" is the option used to add and specify the content type header to application/json whcih indicates that the data being sent is in JSON format. 
# -H "apikey: pQrz7Yr3gX" is the option used to add and set the apikey header to a specific value for authentication purposes.
# -d "{\"occupancy\": ${occupancy_value}}" is used to include data in the request body- occupancy. The -d flag indicates the following string id the data that is sent. This particular case is a JSON string containing the key-value pair of 'occupancy' as key and '${occupancy_value}' as value.
# https://3.128.186.180:7304/room_occupancy/${hall}/${room} is the url where the request will be sent. The room and hall values will replace ${room} and ${hall} corresponding to the each case and execution.
# https is used instead of http for security.

