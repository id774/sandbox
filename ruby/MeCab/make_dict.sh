#!/bin/bash

# はてなキーワード
curl -L http://d.hatena.ne.jp/images/keyword/keywordlist_furigana.csv | iconv -f euc-jp -t utf-8 > keywordlist_furigana.csv
# Wikipedia
curl -L http://dumps.wikimedia.org/jawiki/latest/jawiki-latest-all-titles-in-ns0.gz | gunzip > jawiki-latest-all-titles-in-ns0

# 名詞を抽出して CSV ファイル生成
/opt/ruby/current/bin/ruby make_mecab_dict.rb

# ユーザー辞書ファイル生成
/usr/local/libexec/mecab/mecab-dict-index -d /usr/local/lib/mecab/dic/ipadic -u custom.dic -f utf-8 -t utf-8 custom.csv
