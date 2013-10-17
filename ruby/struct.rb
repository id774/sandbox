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
p Person.constants
p Person.ancestors
p tanaka.methods

StructPerson = Struct.new("StructPerson", :name, :age)

suzuki = StructPerson.new("鈴木", 30)
satou  = StructPerson.new("佐藤", 31)

p suzuki.name
p satou.age
p suzuki
p satou.class
p Struct.constants
p Struct.ancestors
p satou.methods

class MyPerson < Struct.new(:name, :age); end

katou  = MyPerson.new("加藤", 40)
sasaki = MyPerson.new("佐々木", 41)

p katou.name
p sasaki.age
p katou
p sasaki.class
p MyPerson.constants
p MyPerson.ancestors
p sasaki.methods

OpenStructPerson = Struct.new :name, :age do
  def some_method
    "some_method"
  end
end

nakata = OpenStructPerson.new("中田", 50)
miyata = OpenStructPerson.new("宮田", 51)

p nakata.name
p miyata.age
p nakata
p miyata.class
p OpenStructPerson.constants
p OpenStructPerson.ancestors
p miyata.methods
p miyata.some_method

