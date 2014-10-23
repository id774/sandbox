#!/bin/sh

sudo cp $HOME/sandbox/ruby/stock/stocks.sh /var/stock/
sudo cp $HOME/sandbox/ruby/stock/stocks.txt /var/stock/
sudo cp $HOME/sandbox/ruby/stock/stockplot.py /var/stock/
sudo cp $HOME/sandbox/ruby/stock/jpstocks.rb /var/stock/
sudo chown -R root:adm /var/stock
sudo chmod -R g+r,o-rwx /var/stock

