#!/bin/bash
# stocks.sh: Scheduled stock quote collection
#
# Description:
# Run jpstock.rb in /var/stock with stocks.txt and fluentd logging, appending
# its output to /var/log/sysadmin/stock.log.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash stocks.sh
#
# Requirements:
# - Bash
# - Ruby at /opt/ruby/current/bin/ruby with the requirements of jpstock.rb
# - /var/stock prepared by deploy_stock_scripts.sh and write access to
#   /var/log/sysadmin
#

JOBLOG=/var/log/sysadmin/stock.log
WORK_DIR=/var/stock
RUBY=/opt/ruby/current/bin/ruby
PYTHON=/opt/python/current/bin/python

cd $WORK_DIR
$RUBY jpstock.rb -f stocks.txt -l>>$JOBLOG 2>&1
# ruby jpstock.rb -f stocks.txt -d 2000-01-01 -l>>$JOBLOG 2>&1
# $PYTHON stockplot.py>>$JOBLOG 2>&1
