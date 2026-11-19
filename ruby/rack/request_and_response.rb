#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# request_and_response.rb: Rack application branching on the request method
#
# Description:
# Build a Rack application that branches on the request method.
# request_and_response_test.rb tests it.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Requirements:
# - Ruby
# - The rack gem
#

require 'rack/request'
require 'rack/response'

class SampleApp
  def call(env)
    req = Rack::Request.new(env)

    body = case req.request_method
           when 'GET'
             '<html><body><form method="POST"><input type="submit" value="Welcome" /></form></body></html>'
           when 'POST'
             '<html><body>It\'s So good request</body></html>'
           end

    res = Rack::Response.new {|r|
      r.status = 200
      r['Content-Type'] = 'text/html;charset=utf-8'
      r.write body
    }
    res.finish
  end
end
