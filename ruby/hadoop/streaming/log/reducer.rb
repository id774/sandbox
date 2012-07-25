#!/usr/bin/env ruby

require 'resolv'
require 'tempfile'

class Reducer
  def self.ipcount
    wordhash = {}
    $stdin.each_line do |line|
      word, count = line.strip.split
      if wordhash.has_key?(word)
        wordhash[word] += count.to_i
      else
        wordhash[word] = count.to_i
      end
    end
    wordhash
  end

  def self.resolve
    `hive -e 'select ip, host from resolved;'`
  end

  def self.reflesh(f)
    `hive -e 'load data local inpath "#{f.path}"
     overwrite into table resolved;'`
  end

  def self.update(hosts)
    f = Tempfile::new("tempfile")
    hosts.each {|key, value|
      f << "#{key}\t#{value}\n"
    }
    f.close
    reflesh(f)
 end

  def self.resolving(ip)
    begin
      host = Resolv.getname(ip)
    rescue Resolv::ResolvError
      host = 'UNKNOWN'
    end
  end

  def self.resolved
    hash = Hash.new
    hash.default = 'UNKNOWN'
    resolve.each_line {|line|
      ip, host = line.split
      hash[ip] = host
    }
    hash
  end

  def self.reduce
    wordhash = ipcount
    hosts = resolved
    hash = Hash.new
    wordhash.each {|ip, count|
      if hosts.key? ip
        host = hosts[ip]
      else
        host = resolving(ip)
      end
      hash[ip] = host unless hash.key? ip
      puts "#{ip}\t#{host}\t#{count}"
    }
    hosts = hosts.merge(hash)
    update(hosts)
  end
end

Reducer.reduce
