#!/bin/sh
# get_aozora.sh: Fetch an Aozora Bunko text and extract its nouns
#
# Description:
# Download an Aozora Bunko archive into ~/tmp, unpack it, convert the text to
# UTF-8 with ~/scripts/aozora_prepare.rb, and extract its nouns with
# extract_noun.py.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh get_aozora.sh
#
# Requirements:
# - A POSIX shell, curl, and unzip
# - Ruby and ~/scripts/aozora_prepare.rb, which this repository does not
#   include
# - Python with the requirements of extract_noun.py
# - Network access to www.aozora.gr.jp
#

curl -o ~/tmp/2093_ruby_28087.zip http://www.aozora.gr.jp/cards/000096/files/2093_ruby_28087.zip
unzip -d ~/tmp ~/tmp/2093_ruby_28087.zip
rm ~/tmp/2093_ruby_28087.zip
ruby ~/scripts/aozora_prepare.rb ~/tmp/dogura_magura.txt ~/tmp/dogura_magura_utf8.txt
rm ~/tmp/dogura_magura.txt
python extract_noun.py ~/tmp/dogura_magura_utf8.txt
