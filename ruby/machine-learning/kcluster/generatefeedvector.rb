#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-
# Build word count vectors from English RSS feeds.

require 'rubygems'
require 'simple-rss'
require 'open-uri'
require 'cgi'
require 'pp'
require 'hpricot'

class FeedVectorGenerator

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
    return rss.channel.title, wc
  end

  # Strip HTML down to lowercase letters and return them as an array
  def getwords(html)
    # Remove every HTML tag
    doc = Hpricot(html)
    txt = doc.inner_text

    # Split on every non-alphabetic character
    words = txt.split(/[^A-Z^a-z]+/)

    # Convert to lowercase
    words_lower = Array.new
    words.each{ |word|
      words_lower.push(word.downcase)
    }

    return words_lower
  end

  # Build the word frequency table from the feeds
  def generate(filename='blogdata.txt')
    apcount = Hash.new(0) # number of blogs each word appears in
    wordcounts = Hash.new
    feedlist = Array.new
    open('feedlist.txt'){ |file|
      file.each{ |line|
        line = line.gsub(/\r|\n/,'') # strip the newlines
        feedlist.push(line)
      }
    }

    # Process only the first three feeds for now
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
