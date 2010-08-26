require "rubygems"
require "mechanize"
require "yaml"

ta = YAML.load_file(ENV['HOME']+"/.twitter")
agent = WWW::Mechanize.new

#login to twitter
agent.get("http://twitter.com/")
lf = agent.page.form_with(:action => "https://twitter.com/sessions")
lf.field_with(:name => "session[username_or_email]").value = ta["username"]
lf.field_with(:name => "session[password]").value = ta["password"]
lf.click_button

#get posts
tmp = nil
loop do
    begin
    agent.get("http://twitter.com/home")
    pvs = agent.page.search(".entry-content").to_a.map{|x| x.inner_text }
    pus = agent.page.search(".screen-name").to_a.map{|x| x.inner_text }
    ps = []
    pvs.each_index do |i|
        ps[i] = [pus[i],pvs[i]]
    end
    ps.each do |p|
        break if tmp == p[1]
        puts "#{p[0]}: #{p[1]}"
    end
    tmp = ps[0][1]
    sleep 2
    rescue WWW::Mechanize::ResponseCodeError
        puts "ERROR: RETRY"
        sleep 15
        retry
    end
end
