# Video Stuff

## What we need to showcase
### Main Overview
- magnet sensor triping when walking through a door
- basics of thermal camera working when mag sensor is tripped
    - MQTT message publishing true
    - website updating
- thermal camera continuosly running based on people being in the room
    - Maybe have console??
- person leaving and camera turning off
    - MQTT message publishing false
    - website updating

### Multiple people
- one person walk in
    - MQTT publish true
    - website updates
- another walks in
    - everything stays the same
- one walks out
    - same
- other walks out
    - MQTT puslishes false
    - website updates

