#!/bin/bash

# https://www.backblaze.com/hard-drive-test-data.html

curl -L https://docs.backblaze.com/public/hard-drive-data/2014_data.zip -O
unzip 2014_data.zip

sqlite3 drive_stats.db < create_table.sql
sqlite3 drive_stats.db < import.sql
sqlite3 drive_stats.db < stats.sql
sqlite3 drive_stats.db < show.sql
