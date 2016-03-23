gem 'minitest'

require 'minitest/autorun'
require 'erb'
require 'set'
require 'uri'
require 'termtter'

def normalize_as_user_name(text)
  text.strip.sub(/^@/, '')
end

def select(arg)
  case arg
  when /^\d+/
    arg.to_i
  when /^@([A-Za-z0-9_]+)/
    user_name = normalize_as_user_name($1)
    statuses = Termtter::API.twitter.user_timeline(:screen_name => user_name)
    return if statuses.empty?
    statuses[0].id
  when %r{twitter.com/(?:\#!/)[A-Za-z0-9_]+/status(?:es)?/\d+},
    %r{twitter.com/[A-Za-z0-9_]+}
    URI.parse(arg).path.split(%{/}).last.to_i
  when /^\/(.*)$/
    word = $1
    raise "Not implemented yet."
  else
    if public_storage[:typable_id] && typable_id?(arg)
      typable_id_convert(arg)
    else
      return
    end
  end
end

class TestSelect < MiniTest::Test
  def test_select
    expected = 711901052023341060

    h = "https://twitter.com/twitt/status/711901052023341060"
    ans = select(h)
    assert_equal expected, ans

    h = "https://twitter.com/711901052023341060"
    ans = select(h)
    assert_equal expected, ans
  end
end

MiniTest.autorun
