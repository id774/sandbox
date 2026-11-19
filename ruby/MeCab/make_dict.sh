#!/bin/bash
# make_dict.sh: Build a MeCab user dictionary from Hatena and Wikipedia titles
#
# Description:
# Download the Hatena keyword list and the Japanese Wikipedia title list,
# extract nouns into custom.csv with make_mecab_dict.rb, and compile
# custom.dic with mecab-dict-index.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash make_dict.sh
#
# Requirements:
# - Bash, curl, iconv, and gunzip
# - Ruby at /opt/ruby/current/bin/ruby
# - MeCab with the IPA dictionary under /usr/local/lib/mecab/dic/ipadic and
#   mecab-dict-index under /usr/local/libexec/mecab
# - Network access to d.hatena.ne.jp and dumps.wikimedia.org
#

# はてなキーワード
curl -L http://d.hatena.ne.jp/images/keyword/keywordlist_furigana.csv | iconv -f euc-jp -t utf-8 > keywordlist_furigana.csv
# Wikipedia
curl -L http://dumps.wikimedia.org/jawiki/latest/jawiki-latest-all-titles-in-ns0.gz | gunzip > jawiki-latest-all-titles-in-ns0

# 名詞を抽出して CSV ファイル生成
/opt/ruby/current/bin/ruby make_mecab_dict.rb

# ユーザー辞書ファイル生成
/usr/local/libexec/mecab/mecab-dict-index -d /usr/local/lib/mecab/dic/ipadic -u custom.dic -f utf-8 -t utf-8 custom.csv
