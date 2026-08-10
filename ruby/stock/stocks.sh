#!/bin/bash

JOBLOG=/var/log/sysadmin/stock.log
WORK_DIR=/var/stock
RUBY=/opt/ruby/current/bin/ruby
PYTHON=/opt/python/current/bin/python

cd $WORK_DIR
$RUBY jpstock.rb -f stocks.txt -l>>$JOBLOG 2>&1
# ruby jpstock.rb -f stocks.txt -d 2000-01-01 -l>>$JOBLOG 2>&1
# $PYTHON stockplot.py>>$JOBLOG 2>&1
