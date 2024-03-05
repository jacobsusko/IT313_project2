#!/bin/bash
# Author: Chayse
# Define PostgreSQL connection details
HOST="localhost"
PORT="3254"
DB="occupancy"
USER="centralteam"

# Execute SQL query to insert values from source_table into target_table
PGPASSWORD="C3n7r@1^73@NN" psql -h $HOST -p $PORT -d $DB -U $USER  -c "
INSERT INTO occupancy.\"Study_Room_History\" (room_num, hall_name, date_time, occupied, flag)
SELECT room_num, hall_name, date_trunc('minute', CURRENT_TIMESTAMP) AT TIME ZONE 'America/New_York', occupied, flag
FROM occupancy.\"Study_Room\";
"
