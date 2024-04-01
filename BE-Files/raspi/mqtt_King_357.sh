#!/bin/bash

# Author: May & Andrew
# This code has been tested.

while true; do
  mosquitto_sub -C 1 -t topicKing357 > /home/be313/BE/temp_occ/temp_King_357.txt
  mv /home/be313/BE/temp_occ/temp_King_357.txt /home/be313/BE/track_occ/King_357.txt

  chmod 777 /home/be313/BE/track_occ/King_357.txt # Gives full permissions to access the .txt file.
done

# this script puts that associated esp32's output that is subscribed under the topic(topicKing357) and puts it in the temp.txt(temp_King_357.txt) file and puts it in the final occupancy (King_357.txt) file.
