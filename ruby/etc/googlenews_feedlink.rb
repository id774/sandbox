
s = "http://news.google.com/news/url?sa=t&fd=R&ct2=us&usg=AFQjCNGhIFo1illQ6jFyVGPZtfkttFaJYQ&clid=c3a7d30bb8a4878e06b80cf16b898331&cid=52779138313507&ei=Pts3VLDAD4X7kgWO9oGIBg&url=http://www.yomiuri.co.jp/world/20141010-OYT1T50090.html"

if s.index("http://news.google.com")
  m = s.match(/(&url=)/)
  unless m.nil?
    new_link = m.post_match
    s = new_link unless new_link.nil?
  end
end

p s
