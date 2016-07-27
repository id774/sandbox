#!/bin/sh

/usr/bin/pg_dumpall -c > /var/lib/postgresql/backup/all.dump && gzip -f /var/lib/postgresql/backup/all.dump>/dev/null 2>&1
