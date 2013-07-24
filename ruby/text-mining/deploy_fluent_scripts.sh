#!/bin/sh

sudo cp $HOME/sandbox/ruby/text-mining/fluentd_wordcount.rb /home/fluent/.fluent/bin/
sudo cp $HOME/sandbox/ruby/text-mining/news_hottopic.rb /home/fluent/.fluent/bin/
sudo cp $HOME/sandbox/ruby/text-mining/mongo_fluentd_wordcount.rb /home/fluent/.fluent/bin/
sudo cp $HOME/sandbox/ruby/text-mining/mongo_news_hottopic.rb /home/fluent/.fluent/bin/
sudo chown -R fluent:fluent /home/fluent/.fluent/bin/
sudo chmod 660 /home/fluent/.fluent/bin/*

