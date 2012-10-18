#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

def test
  yield
end

test{puts "hoge"}

def test2
  yield "hoge"
end

test2{|x| puts x}

def test3
  yield "hoge", 100
end

test3{|x, y| print x, y, "\n"}

def test4
  if block_given?
    yield
  else
    puts "no blcock"
  end
end

test4{puts "hoge"}
test4

def test5
  for i in [1,2,3]
    yield
  end
end

test5{puts "hoge"}

def test6
  for i in [1,2,3]
    yield i
  end
end

test6{|x| puts x}

def test7
  for i in [1,2,3]
    yield i, "hoge"
  end
end

test7{|x,y| print  x, y, "\n"}

def test8(val)
  for i in [1,2,3,4,5]
    yield i, "hoge"  if i > val
  end
end

test8(0){|x,y| print x, y, "\n"}
test8(2){|x,y| print x, y, "\n"}
