#!/bin/bash

JOBLOG=/var/log/sysadmin/stock.log
WORK_DIR=/var/stock

cd $WORK_DIR
ruby jpstock.rb -f stocks.txt -l>>$JOBLOG 2>&1
#ruby jpstock.rb -f stocks.txt -d 2000-01-01 -l>>$JOBLOG 2>&1
