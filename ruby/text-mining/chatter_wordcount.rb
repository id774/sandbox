# -*- coding: utf-8 -*-

require 'MeCab'
require 'sqlite3'

class MapReduce
  def map_reduce
    @mecab = MeCab::Tagger.new("-Ochasen")
    mapper_hash = {}
    @hits = {}
    db = SQLite3::Database.new(Storage.db_filename)
    db.execute(Storage.sql).each {|row|
      mapper(row[3]).each {|word|
        if word.length > 1
          if word =~ /[亜-腕]/
            reducer(word)
          end
        end
      }
    }
    db.close
    i = 0
    @hits.sort_by{|k,v| -v}.each {|k, v|
      i = i + 1
      puts "#{i.to_s}\t#{k}\t#{v}\n" if i <= 100
    }
  end

  private
  def reducer(word)
    @hits.has_key?(word) ? @hits[word] += 1 : @hits[word] = 1
  end

  def mapper(string)
    node = @mecab.parseToNode(string)
    nouns = []
    while node
      if /^名詞/ =~ node.feature.force_encoding("utf-8").split(/,/)[0] then
        nouns.push(node.surface.force_encoding("utf-8"))
      end
      node = node.next
    end
    nouns
  end
end

class Storage
  class << self
    def db_filename
      db_name = 'chatter.db'
      db_path = File.expand_path(File.join(File.dirname(__FILE__), db_name))
    end

    def sql
      sql = "select
             feedposts.Id,
             feedposts.CreatedDate,
             feedposts.Title,
             feedposts.Body,
             feedposts.LinkUrl,
             feedposts.IsDeleted,
             users.Id,
             users.Username,
             users.FirstName,
             users.LastName,
             users.CompanyName,
             users.Division,
             users.Department,
             users.Title,
             users.IsActive,
             users.Email
             from feedposts left join users on (feedposts.CreatedById = users.Id)"
    end
  end
end

map_reduce = MapReduce.new
map_reduce.map_reduce

