#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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
