#!/bin/sh

JOBLOG=/var/log/sysadmin/make_mecab_dic.log

echo -n "*** $0: Job started on `/bin/hostname` at ">>$JOBLOG 2>&1
date "+%Y/%m/%d %T">>$JOBLOG 2>&1

cd /home/mecab/dic
curl -L http://d.hatena.ne.jp/images/keyword/keywordlist_furigana.csv | iconv -f euc-jp -t utf-8 > keywordlist_furigana.csv
curl -L http://dumps.wikimedia.org/jawiki/latest/jawiki-latest-all-titles-in-ns0.gz | gunzip > jawiki-latest-all-titles-in-ns0
/opt/ruby/current/bin/ruby make_mecab_dict.rb>>$JOBLOG 2>&1
/usr/local/libexec/mecab/mecab-dict-index -d /usr/local/lib/mecab/dic/ipadic -u custom.dic -f utf-8 -t utf-8 custom.csv>>$JOBLOG 2>&1
chown -R root:fluent /home/mecab/dic>>$JOBLOG 2>&1

echo -n "*** $0: Job ended on `/bin/hostname` at ">>$JOBLOG 2>&1
date "+%Y/%m/%d %T">>$JOBLOG 2>&1
echo>>$JOBLOG 2>&1

exit 0
