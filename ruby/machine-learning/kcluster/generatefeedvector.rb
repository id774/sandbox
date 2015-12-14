#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'simple-rss'
require 'open-uri'
require 'cgi'
require 'pp'
require 'hpricot'

class FeedVectorGenerator

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
    return rss.channel.title, wc
  end

  # HTMLからアルファベット小文字のみを抜き出し配列として返す
  def getwords(html)
    # HTMLタグを全て取り除く
    doc = Hpricot(html)
    txt = doc.inner_text

    # すべての非アルファベット文字で分割する
    words = txt.split(/[^A-Z^a-z]+/)

    # 小文字に変換する
    words_lower = Array.new
    words.each{ |word|
      words_lower.push(word.downcase)
    }

    return words_lower
  end

  # Feedから単語頻出表を生成する
  def generate(filename='blogdata.txt')
    apcount = Hash.new(0) # それぞれの単語が出現するblogの数
    wordcounts = Hash.new
    feedlist = Array.new
    open('feedlist.txt'){ |file|
      file.each{ |line|
        line = line.gsub(/\r|\n/,'') # 改行を削除
        feedlist.push(line)
      }
    }

    # とりあえず3件だけfeed処理
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
