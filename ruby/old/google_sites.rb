# google_sites.rb - Google Site Data API Ruby wrapper
# Author: Sora Harakami <sora134[at]gmail.com>
# Licence: MIT Licence
# Require: net/https

require "pp"
require "net/https"
require "rexml/document"

Net::HTTP.version_1_2

class GoogleClientLogin
    def initialize(conf = {})
        @config = {:source => "foo-bar-1",:account_type => 'HOSTED_OR_GOOGLE'}.merge(conf)
        raise ArgumentError, "conf is not Hash" unless @config.kind_of?(Hash)
        raise ArgumentError, ":email is not string" unless @config[:email].kind_of?(String)
        raise ArgumentError, ":password is not string" unless @config[:password].kind_of?(String)
        raise ArgumentError, ":source is not string" unless @config[:source].kind_of?(String)
        raise ArgumentError, ":service is not string" unless @config[:service].kind_of?(String)
        raise ArgumentError, ":account_type is not string" unless @config[:account_type].kind_of?(String)
        @auth_key = nil
    end

    def login
        hs = Net::HTTP.new("www.google.com",443)
        hs.use_ssl = true
        hs.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        b = hs.start{|h|
            h.post(
                'https://www.google.com/accounts/ClientLogin',
                {
                    'Email' => @config[:email],
                    'Passwd' => @config[:password],
                    'source' => @config[:source],
                    'service' => @config[:service],
                    'accountType' => @config[:account_type]
                }.map {|k,v| "#{k}=#{v}"}.join('&')
            ).body.lines.to_a.map{|e| e.split("=") }.flatten
        }
        r = Hash[*b]
        raise GoogleClientLogin::LoginFailture,"Login failture" if r['Auth'].nil?
        @auth_key = r['Auth'].chomp
        return self
    end

    def token; @auth_key; end
    class LoginFailture < Exception; end

    attr_reader :auth_key
end


class GoogleSites
    class APIError < Exception; end

    def initialize(conf = {})
        @config = {:service => 'jotspot', :source => 'sorah-gsitesrb-1', :domain => 'site'}.merge(conf)
        raise ArgumentError, ":service is not string" unless @config[:service].kind_of?(String)
        raise ArgumentError, ":source is not string" unless @config[:source].kind_of?(String)
        raise ArgumentError, ":email is not string" unless @config[:email].kind_of?(String)
        raise ArgumentError, ":password is not string" unless @config[:password].kind_of?(String)
        raise ArgumentError, ":site_name is not string" unless @config[:site_name].kind_of?(String)
        @token = GoogleClientLogin.new(@config).login.token
        @pages = []
    end

    def get_page_list()
        feed_url = "/feeds/content/#{@config[:domain]}/#{@config[:site_name]}"
        feed_raw = connect(feed_url)
        raise GoogleSites::APIError unless feed_raw.code == '200'
        feed = REXML::Document.new(feed_raw.body)
        feed.elements['/feed'].each do |e|
            if e.name == "entry"
                url = ""
                hsh = {
                    :id => e.elements['id'].text.gsub(/^.+\//,""),
                    :url => e.elements['link[@rel=\'self\']'].attributes['href'],
                    :title => e.elements['title'].text,
                    :body => e.elements['content'].to_s.sub(/^<content type='xhtml'>/,"").sub(/<\/content>$/,"")
                }
                @pages << Page.new(hsh) if hsh[:title].kind_of?(String) && hsh[:body].kind_of?(String) && hsh[:url].kind_of?(String) && hsh[:id].kind_of?(String)
            end
        end
        return @pages
    end

    def create_page(param = {})
        raise ArgumentError, ":title is not string" unless param[:title].kind_of?(String)
        raise ArgumentError, ":body is not string" unless param[:body].kind_of?(String)
        raise ArgumentError, ":parent is not string" unless param[:parent].kind_of?(String) || param[:parent].nil?
        raise ArgumentError, ":content_type is not string" unless param[:content_type].kind_of?(String) || param[:content_type].nil?
        raise ArgumentError, ":page_name is not string" unless param[:page_name].kind_of?(String) || param[:page_name].nil?
        
        url = "/feeds/content/#{@config[:domain]}/#{@config[:site_name]}"
        parent = param[:parent].nil? ? '' : '\n<link rel="http://schemas.google.com/sites/2008#parent" type="application/atom+xml" href="http://sites.google.com/feeds/content/'+@config[:domain]+'/'+@config[:site_name]+'/'+param[:parent]+'"/>'
        content_type = param[:content_type].nil? ? 'xhtml' : param[:content_type]
        page_name = param[:page_name].nil? ? '' : '\n<sites:pageName>'+param[:page_name]+'</sites:pageName>'
        put = <<-EOF
<entry xmlns="http://www.w3.org/2005/Atom" xmlns:sites="http://schemas.google.com/sites/2008">
  <category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/sites/2008#webpage" label="webpage"/>#{parent}
  <title>#{param[:title]}</title>
  <content type="#{content_type}">
    <div xmlns="http://www.w3.org/1999/xhtml">
      #{param[:body]}
    </div>
  </content>#{page_name}
</entry>
        EOF
        r = cpost(url,put,{"Content-Type" => "application/atom+xml"})
        raise GoogleSites::APIError, r.body unless r.code == '201'
        e = REXML::Document.new(r.body).elements['/entry']
        page = Page.new(
            :id => e.elements['id'].text.gsub(/^.+\//,""),
            :url => e.elements['link[@rel=\'self\']'].attributes['href'],
            :title => e.elements['title'].text,
            :body => e.elements['content'].to_s.sub(/^<content type='xhtml'>/,"").sub(/<\/content>$/,"")
        )
        @pages << page
        return page
    end

    def update_page(p)
    end



    attr_reader :token,:pages,:config

    class Page
        def initialize(param = {})
            raise ArgumentError, ":title is not string" unless param[:title].kind_of?(String)
            raise ArgumentError, ":body is not string" unless param[:body].kind_of?(String)
            raise ArgumentError, ":url is not string" unless param[:url].kind_of?(String)
            raise ArgumentError, ":id is not string" unless param[:id].kind_of?(String)
            @title = param[:title]
            @body = param[:body]
            @url = param[:url]
            @id = param[:id]
        end

        def update(p = {})
            param = {
                :title => @title,
                :body => @body,
                :id => @id,
                :url => @url
            }.merge(p)

            initialize(param)
        end

        attr_reader :title,:body,:url,:id
    end
    
private
    def connect(path,mode=:get,post=nil,ha={},host='sites.google.com',ssl=true)
        raise ArgumentError, "path is not string" unless path.kind_of?(String)
        raise ArgumentError, "post is not string" unless path.kind_of?(String) || path.nil?
        raise ArgumentError, "host is not string" unless path.kind_of?(String)
        raise ArgumentError, "ssl is not true or false" unless ssl.kind_of?(TrueClass) || ssl.kind_of?(FalseClass)
        raise ArgumentError, "post is not string" if post.nil? && mode != :get
        port = ssl ? 443 : 80
        hs = Net::HTTP.new(host,port)
        if ssl
            hs.use_ssl = true
            hs.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        hs.start do |h|
            if mode == :post
                return h.post(path,post,{"Authorization" => "GoogleLogin auth=#{@token}", "GData-Version" => "1.0"}.merge(ha))
            elsif mode == :put
                req = Net::HTTP::Put.new(path)
                req["Authorization"] = "GoogleLogin auth=#{@token}"
                req["GData-Version"] = "1.0"
                return h.request(req, post)
            else
                return h.get(path, {"Authorization" => "GoogleLogin auth=#{@token}", "GData-Version" => "1.0"}.merge(ha))
            end
        end
    end

    def cput(path,put,h={},host='sites.google.com',ssl=true)
        connect(path,:put,put,h,host,ssl)
    end

    def cpost(path,post,h={},host='sites.google.com',ssl=true)
        connect(path,:post,post,h,host,ssl)
    end
end

if __FILE__ == $0
    g = GoogleSites.new({:email => ARGV[0],:password => ARGV[1],:site_name => "sorahar"})
    page_vi = g.create_page(:title => "vi",:body => "hivihivihivhivhivhivhivdjsdfisdjfsjf",:page_name => "page-vi")
    pp g.create_page(:title => "vi_childen",:body => "Hello. I'm vi's children, name is Vim.",:page_name => "page-vim",:parent => page_vi.id)
end
