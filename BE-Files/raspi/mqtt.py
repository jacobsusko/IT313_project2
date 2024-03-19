Author: Rafael Margary
#This code will handle the mqtt messages coming from the esp32
from platypush.event.hook import hook
from platypush.utils import run
from platypush.backend.mqtt import MQTTMessageEvent 
import subprocess

@hook(MQTTMessageEvent)
def send():
        subprocces.run(['curl -X PUT -H "Content-Type: application/json" -H "apikey: XXXXXXXXXX" -d "{\"occupancy\": true}" https://jmustudyhall.com:7304/room_occupancy/King/357'])

