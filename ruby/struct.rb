#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

class Person
  def initialize(name, age)
    @name = name
    @age  = age
  end
  attr_accessor :name, :age
end

yamada = Person.new("山田", 20)
tanaka = Person.new("田中", 21)

p yamada.name
p tanaka.age
p yamada
p tanaka.class
p tanaka.methods

struct_person = Struct.new("StructPerson", :name, :age)

suzuki = struct_person.new("鈴木", 30)
satou  = struct_person.new("佐藤", 31)

p suzuki.name
p satou.age
p suzuki
p satou.class
p satou.methods

class MyPerson < Struct.new(:name, :age); end

katou  = MyPerson.new("加藤", 40)
sasaki = MyPerson.new("佐々木", 41)

p katou.name
p sasaki.age
p katou
p sasaki.class
p sasaki.methods

