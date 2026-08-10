#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-
# Build word count vectors from Japanese RSS feeds with MeCab.

require 'rubygems'
require 'simple-rss'
require 'open-uri'
require 'cgi'
require 'pp'
require 'hpricot'
require 'MeCab'
require 'kconv'

class FeedVectorGeneratorJp

  # Return the feed title and a dictionary of word frequencies
  def getwordcounts(url)
    # Parse the feed
    rss = SimpleRSS.parse(open(url).read)
    wc = Hash.new(0) # default to 0

    # Loop over every entry
    rss.items.each{ |item|
      # Read the body
      summary = item.content if item.content != nil # for Atom
      summary = item.description if item.description != nil # for RSS

      # Extract the list of words
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

  # Strip HTML down to lowercase letters and return them as an array
  def getwords(html)
    # Remove every HTML tag
    doc = Hpricot(html)
    txt = doc.inner_text

    # Extract the words
    mecab = MeCab::Tagger.new('-Ochasen')
    n = mecab.parseToNode( CGI.unescapeHTML(txt.toutf8) )
    # verbs = getWordsByKind(n, '動詞')
    nouns = getWordsByKind(n, '名詞') # nouns only

    words = Array.new
    nouns.each{ |w|
      words.push(w) if w =~ /\w{2,}/ # two characters or more
    }
    return nouns
  end

  # Build the word frequency table from the feeds
  def generate(filename='blogdatajp.txt')
    apcount = Hash.new(0) # number of blogs each word appears in
    wordcounts = Hash.new
    feedlist = Array.new
    open('feedlistjp.txt'){ |file|
      file.each{ |line|
        line = line.gsub(/\r|\n/,'') # strip the newlines
        feedlist.push(line)
      }
    }

#    feedlist = ['http://www.daito.ws/weblog/atom.xml',
#                'http://www.ok.kmd.keio.ac.jp/feed/',
#                'http://d.hatena.ne.jp/kyoro353/rss',
#                'http://www.uchidayu.net/diary/?feed=rss2',
#                'http://d.hatena.ne.jp/makaronisan/rss']
#
    # Process the feeds
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

      # Print the word list
      wordlist.each{ |word|
        out.write("\t" + word)
      }
      out.write("\n")

      # Print the count for each word
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
