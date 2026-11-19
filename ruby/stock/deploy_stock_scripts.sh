#!/bin/sh
# deploy_stock_scripts.sh: Deploy the stock scripts to /var/stock
#
# Description:
# Copy stocks.sh, stockplot.py, and jpstock.rb from ~/sandbox/ruby/stock to
# /var/stock with sudo, then give the directory to root:adm and remove access
# for other users.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh deploy_stock_scripts.sh
#
# Requirements:
# - A POSIX shell
# - sudo privilege and this repository checked out at ~/sandbox
#

sudo cp $HOME/sandbox/ruby/stock/stocks.sh /var/stock/
sudo cp $HOME/sandbox/ruby/stock/stockplot.py /var/stock/
sudo cp $HOME/sandbox/ruby/stock/jpstock.rb /var/stock/
sudo chown -R root:adm /var/stock
sudo chmod -R g+r,o-rwx /var/stock

