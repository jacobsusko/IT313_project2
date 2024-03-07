# Author: May
# This code has been tested and exercised

#!/bin/bash
hall="King"
room="357"
occupancy_value=true

curl -X PUT -H "Content-Type: application/json" -H "apikey: pQrz7Yr3gX" -d "{\"occupancy\": ${occupancy_value}}" http://3.128.186.180:7304/room_occupancy/${hall}/${room}