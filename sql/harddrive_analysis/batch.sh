#!/bin/bash
# batch.sh: Load and analyze Backblaze hard drive data in SQLite
#
# Description:
# Download the 2014 Backblaze hard drive test data, unpack it, and run
# create_table.sql, import.sql, stats.sql, and show.sql against
# drive_stats.db. The comment below names the data source.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash batch.sh
#
# Requirements:
# - Bash, curl, and unzip
# - SQLite 3 with the sqlite3 command
# - Network access to docs.backblaze.com
#

# https://www.backblaze.com/hard-drive-test-data.html

curl -L https://docs.backblaze.com/public/hard-drive-data/2014_data.zip -O
unzip 2014_data.zip

sqlite3 drive_stats.db < create_table.sql
sqlite3 drive_stats.db < import.sql
sqlite3 drive_stats.db < stats.sql
sqlite3 drive_stats.db < show.sql
