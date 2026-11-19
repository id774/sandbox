#!/bin/sh
# wakati.sh: Segment text files with MeCab
#
# Description:
# Write a word-segmented copy, <name>.wakati.txt, of every .txt file under the
# current directory with MeCab.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh wakati.sh
#
# Requirements:
# - A POSIX shell and GNU find
# - MeCab with the mecab command
#

for file in `find -type f -name "*.txt"`
do
    mecab -O wakati -o $file.wakati.txt $file
done
