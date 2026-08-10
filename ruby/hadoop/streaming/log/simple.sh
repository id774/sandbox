#!/bin/sh

cat data.txt | ruby mapper.rb | sort | ruby reducer.rb
