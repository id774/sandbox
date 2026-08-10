#!/bin/sh

cat data.txt | ruby ip_mapper.rb | sort | ruby ip_reducer.rb
