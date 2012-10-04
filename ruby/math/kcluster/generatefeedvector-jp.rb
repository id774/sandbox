#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'simple-rss'
require 'open-uri'
require 'cgi'
require 'pp'
require 'hpricot'
require 'MeCab'
require 'kconv'

class FeedVectorGeneratorJp

  # RSSフィードのタイトルと、単語の頻度のディクショナリを返す
  def getwordcounts(url)
    # フィードをパースする
    rss = SimpleRSS.parse(open(url).read)
    wc = Hash.new(0) # 初期値0設定

    # 全てのエントリをループする
    rss.items.each{ |item|
      # 本文を読み出す
      summary = item.content if item.content != nil # atomの時
      summary = item.description if item.description != nil # rssの時

      # 単語のリストを取り出す
      words = getwords(item.title + ' ' + summary)
      words.each{ |word|
        wc[word] += 1
      }
    }
    return CGI.unescapeHTML(rss.channel.title.toutf8), wc
  end

  def getWordsByKind(node, kind)
    list = Array.new
    while node do
      f = node.feature.split(/,/)
      if /#{kind}/ =~ f[0]
        list.push(node.surface)
      end
      node = node.next
    end
    return list
  end

  # HTMLからアルファベット小文字のみを抜き出し配列として返す
  def getwords(html)
    # HTMLタグを全て取り除く
    doc = Hpricot(html)
    txt = doc.inner_text

    # 単語を取り出す
    mecab = MeCab::Tagger.new('-Ochasen')
    n = mecab.parseToNode( CGI.unescapeHTML(txt.toutf8) )
    # verbs = getWordsByKind(n, '動詞')
    nouns = getWordsByKind(n, '名詞') # 名詞のみ

    words = Array.new
    nouns.each{ |w|
      words.push(w) if w =~ /\w{2,}/ # 2文字以上
    }
    return nouns
  end

  # Feedから単語頻出表を生成する
  def generate(filename='blogdatajp.txt')
    apcount = Hash.new(0) # それぞれの単語が出現するblogの数
    wordcounts = Hash.new
    feedlist = Array.new
    open('feedlistjp.txt'){ |file|
      file.each{ |line|
        line = line.gsub(/\r|\n/,'') # 改行を削除
        feedlist.push(line)
      }
    }

#    feedlist = ['http://www.daito.ws/weblog/atom.xml',
#                'http://www.ok.kmd.keio.ac.jp/feed/',
#                'http://d.hatena.ne.jp/kyoro353/rss',
#                'http://www.uchidayu.net/diary/?feed=rss2',
#                'http://d.hatena.ne.jp/makaronisan/rss']
#
    # feed処理
    feedlist.each{ |feedurl|
      begin
        title, wc = getwordcounts(feedurl)
        wordcounts[title] = wc
        wc.each{ |word, count|
          if count > 1
            apcount[word] += 1
          end
        }
      rescue
        puts 'Failed to parse feed ' + feedurl
      else
        puts 'Success to parse feed ' + feedurl
      end
    }

    wordlist = Array.new

    apcount.each{ |w,bc|
      frac = Float(bc)/feedlist.length
      if frac > 0.1 && frac < 0.5
        wordlist.push(w)
      end
    }

    File.open(filename, 'w'){ |out|
      out.write('Blog')

      # 単語リスト出力
      wordlist.each{ |word|
        out.write("\t" + word)
      }
      out.write("\n")

      # 単語毎の出現数出力
      wordcounts.each{ |blog, wc|
        out.write(blog)
        wordlist.each{ |word|
          if wc.key?(word)
            out.write("\t" + wc[word].to_s)
          else
            out.write("\t0")
          end
        }
        out.write("\n")
      }
    }

  end
end
