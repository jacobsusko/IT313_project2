#!/bin/bash

# Author: May 
# This code has been tested.

while true; do
  mosquitto_sub -C 1 -t topicKing358 > /home/be313/BE/temp_occ/temp_King_358.txt
  mv /home/be313/BE/temp_occ/temp_King_358.txt /home/be313/BE/track_occ/King_358.txt

  chmod 777 /home/be313/BE/track_occ/King_358.txt # Gives full permissions to access the .txt file.
done