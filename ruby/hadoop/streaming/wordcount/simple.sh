#!/bin/sh

cat data.txt | ruby map.rb | sort | ruby reduce.rb
