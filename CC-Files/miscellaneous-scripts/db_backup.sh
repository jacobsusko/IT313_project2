#!/bin/bash
# Author: Brandon
# Define database connection details
HOST="localhost"
PORT="3254"  # Specify the desired port number
DB="occupancy"
USER="centralteam"
DATE=$(TZ="America/New_York" date +"%Y-%m-%d_%H")

# Perform pg_dump operation
sudo -u postgres PGPASSWORD="C3n7r@1^73@NN" pg_dump -h $HOST -p $PORT -U $USER -d $DB > /home/ec2-user/db_backups/mydatabase_dump_$DATE.sql

