#!/bin/sh
# make_mecab_dict.sh: Scheduled rebuild of the MeCab user dictionary
#
# Description:
# Rebuild the MeCab user dictionary in /home/mecab/dic from the Hatena keyword
# list and the Japanese Wikipedia title list, log the job to
# /var/log/sysadmin/make_mecab_dic.log, and give the directory to root:fluent.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh make_mecab_dict.sh
#
# Requirements:
# - A POSIX shell, curl, iconv, and gunzip
# - Ruby at /opt/ruby/current/bin/ruby and make_mecab_dict.rb in
#   /home/mecab/dic
# - MeCab with the IPA dictionary under /usr/local/lib/mecab/dic/ipadic and
#   mecab-dict-index under /usr/local/libexec/mecab
# - Root privilege for chown and write access to /var/log/sysadmin
#

LC_CTYPE=ja_JP.UTF-8
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
