#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require './request_and_response'
require 'test/unit'
require 'rack/mock'

class SampleAppTest < Test::Unit::TestCase
  def setup
    @app = SampleApp.new
    @mr  = Rack::MockRequest.new(@app)
  end

  def test_get
    res = nil
    assert_nothing_raised('Failed!') { res = @mr.get('/', :lint => true) }
    assert_not_nil res, 'No Response'
    assert_equal 200, res.status, 'StatusCode Erorr'
    assert_equal 'text/html;charset=utf-8', res['Content-Type'], 'Content-Type Error'
    assert_match /Welcome/, res.body, 'html_body Error'
  end

  def test_post
    res = nil
    assert_nothing_raised('Failed!') { res = @mr.post('/', :lint => true) }
    assert_not_nil res, 'No Response'
    assert_equal 200, res.status, 'StatusCode Erorr'
    assert_equal 'text/html;charset=utf-8', res['Content-Type'], 'Content-Type Error'
    assert_match /It's So good request/, res.body, 'html_body Error'
  end
end
