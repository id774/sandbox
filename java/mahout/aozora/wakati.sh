#!/bin/sh

for file in `find -type f -name "*.txt"`
do
    mecab -O wakati -o $file.wakati.txt $file
done
