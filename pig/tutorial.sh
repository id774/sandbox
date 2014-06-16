#!/bin/sh

wget -O  tutorial.tar.gz "https://cwiki.apache.org/confluence/download/attachments/27822259/pigtutorial.tar.gz?version=1&modificationDate=1311188529000"
tar xzvf tutorial.tar.gz
cd pigtmp

test -n "$1" || ../tutorial-run.sh

