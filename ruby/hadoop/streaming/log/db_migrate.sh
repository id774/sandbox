#!/bin/sh
# db_migrate.sh: Recreate the Hive resolved table
#
# Description:
# Drop and recreate the Hive table resolved with tab separated ip and host
# columns.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh db_migrate.sh
#
# Requirements:
# - A POSIX shell
# - Hive with the hive command
#

hive -e 'drop table resolved;'
hive -e 'create table resolved (ip STRING, host STRING) row format delimited fields terminated by "\t";'
