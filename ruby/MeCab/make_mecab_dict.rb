#!/usr/bin/env ruby

# Referring
# http://kzy52.com/entry/2014/10/05/195534
# http://sugamasao.hatenablog.com/entry/2014/11/17/000355

# To get sources, type these
# $ curl -L http://d.hatena.ne.jp/images/keyword/keywordlist_furigana.csv | iconv -f euc-jp -t utf-8 > keywordlist_furigana.csv
# $ curl -L http://dumps.wikimedia.org/jawiki/latest/jawiki-latest-all-titles-in-ns0.gz | gunzip > jawiki-latest-all-titles-in-ns0

# Create dict from CSV
# $ /usr/local/libexec/mecab/mecab-dict-index -d /usr/local/lib/mecab/dic/ipadic -u custom.dic -f utf-8 -t utf-8 custom.csv

# Test
# $ echo 'レーベンシュタイン距離' | mecab --unk-feature "未知語"
#=> レーベンシュタイン      未知語
#=> 距離    名詞,一般,*,*,*,*,距離,キョリ,キョリ
#=> EOS
# $ echo 'レーベンシュタイン距離' | mecab -u custom.dic --unk-feature "未知語"
#=> レーベンシュタイン距離  名詞,一般,*,*,*,*,レーベンシュタイン距離,*,*,wikipedia
#=> EOS

require 'csv'

original_data = {
  wikipedia: 'jawiki-latest-all-titles-in-ns0',
  hatena: 'keywordlist_furigana.csv',
  custom: 'my.csv'
}

CSV.open("custom.csv", 'w') do |csv|
  original_data.each do |type, filename|
    next unless File.file? filename
    open(filename).each do |title|
      title.strip!

      next if title =~ %r(^[+-.$()?*/&%!"'_,]+)
      next if title =~ /^[-.0-9]+$/
      next if title =~ /曖昧さ回避/
      next if title =~ /_\(/
      next if title =~ /^PJ:/
      next if title =~ /の登場人物/
      next if title =~ /一覧/

      title_length = title.length

      if title_length > 3
        score = [-36000.0, -400 * (title_length ** 1.5)].max.to_i
        csv << [title, nil, nil, score, '名詞', '一般', '*', '*', '*', '*', title, '*', '*', type]
      end
    end
  end
end
