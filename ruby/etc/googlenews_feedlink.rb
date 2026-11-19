# googlenews_feedlink.rb: Original article URL from a Google News redirect
#
# Description:
# Recover the original article URL from a Google News redirect.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby googlenews_feedlink.rb
#
# Requirements:
# - Ruby
#

s = "http://news.google.com/news/url?sa=t&fd=R&ct2=us&usg=AFQjCNGhIFo1illQ6jFyVGPZtfkttFaJYQ&clid=c3a7d30bb8a4878e06b80cf16b898331&cid=52779138313507&ei=Pts3VLDAD4X7kgWO9oGIBg&url=http://www.yomiuri.co.jp/world/20141010-OYT1T50090.html"

if s.index("http://news.google.com")
  m = s.match(/(&url=)/)
  unless m.nil?
    new_link = m.post_match
    s = new_link unless new_link.nil?
  end
end

p s
