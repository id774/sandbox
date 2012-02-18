#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class HatenaBookmark
  require 'rubygems'
  require 'time'
  require 'digest/sha1'
  require 'net/http'
  require 'uri'
  #require 'nkf'

  attr_accessor :user

  def initialize
    @user = {
      "hatena_id" => "", 
      "password"  => "", 
    }
  end

  def wsse(hatena_id, password)
    # Unique value
    nonce = [Time.now.to_i.to_s].pack('m').gsub(/\n/, '')
    now = Time.now.utc.iso8601
	
    # Base64 encoding for SHA1 Digested strings
    digest = [Digest::SHA1.digest(nonce + now + password)].pack("m").gsub(/\n/, '')
	
    {'X-WSSE' => sprintf(
      %Q<UsernameToken Username="%s", PasswordDigest="%s", Nonce="%s", Created="%s">,
      hatena_id, digest, nonce, now)
    }
  end

  def genXml(link, summary)
    %Q(
      <entry xmlns="http://purl.org/atom/ns#">
      <title>dummy</title>
      <link rel="related" type="text/html" href="#{link}" />
      <summary type="text/plain">#{summary}</summary>
      </entry>
    )
  end

  def postBookmark(b_url, b_comment)
    url = "http://b.hatena.ne.jp/atom/post"
    header = wsse(user["hatena_id"], user["password"])
    uri = URI.parse(url)
    proxy_class = Net::HTTP::Proxy(ENV["PROXY"], 8080)
    http = proxy_class.new(uri.host)
    http.start do |http|
      # b_url = NKF.nkf('-w', b_url)
      # b_comment = NKF.nkf('-w', b_comment)
      res = http.post(uri.path, genXml(b_url, b_comment), header)
      if res.code == "201" then
        fmt = "%Y/%m/%d %X"
        t = Time.now.strftime(fmt)
        unless b_comment.nil?
          print "#{t} [info] Success: #{b_url} Comment: #{b_comment}\n"
        else
          print "#{t} [info] Success: #{b_url}\n"
        end
      else
        print "#{t} [error] #{res.code} Error: #{b_url}\n"
      end
    end
  end
end

if __FILE__ == $0
  b_url = ARGV.shift || abort("Usage: hatenabookmark.rb <url> <comment>")
  b_comment = ARGV.shift
  hb = HatenaBookmark.new
  hb.postBookmark(b_url, b_comment)
end
