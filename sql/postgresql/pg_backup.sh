#!/bin/sh

/usr/bin/pg_dumpall -c > /var/lib/postgresql/backup/all.dump && gzip /var/lib/postgresql/backup/all.dump
