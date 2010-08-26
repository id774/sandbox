print "hello, lua"
--> hello,lua

print [[Hi.
This way ignore the escape sequence.]]
--> Hi.
--> This way ignore the escape sequence.

-- This is comment
--[[
comment
comment
comment
]]

print("Union " ..
      "Strings")
--> Union Strings
print("")

foo = 10
bar = 20
-- equal
foo = 10 bar = 20
-- equal, too
foo, bar = 10, 20

print(foo) --> 10
print(bar) --> 20
print(foo,bar) --> 10<TAB>20

print("foo is "..foo..".") --> foo is 10
print( string.format("foo is %d", foo) ) --> foo is 10
print( string.format("foo at hexadecimal number is %x", foo) ) --> foo is a
print("")

print(-foo) --> -10
print(foo ^ 10) --> 10000000000
print("")

print(type(nil)) --> nil
print(type("Vim")) --> string
print(type(487)) --> number
print(type(true)) --> boolean
print(type(false)) --> boolean
print("")

-- io.read()

if foo > bar then
    print("foo > bar")
else
    print("foo < bar")
end
--> foo < bar

if foo > bar then
    print("foo > bar")
elseif foo == 11 then
    print("foo < bar")
else
    print("else")
end
--> else

hoge = 0
if hoge then
    print("0 is true")
else
    print("0 isn't true")
end
--> 0 isn't true

if hoge ~= 1 then
-- 'if hoge != 1 then' is error
    print "hoge ~= 1"
end

if hoge and foo then
    print("hoge and foo")
end
--> hoge and foo

if hoge or nil then
    print("hoge or nil")
end
--> hoge or nil

if not nil then
    print("not nil")
end
--> not nil
print("")

-- && || ! is error.

i = 1
while i <= 10 do
    print(i)
    i = i + 1 -- i += 1 is error
end
--> 1
--> 2
--> 3
--> 4
--> 5
--> 6
--> 7
--> 8
--> 9
--> 10
print("")

-- for initialize-value, finalize-value, [amount-of-increase = 1] do
for i = 1, 10, 1 do
    print(i)
end
--> 1
--> 2
--> 3
--> 4
--> 5
--> 6
--> 7
--> 8
--> 9
--> 10
print("")

i = 1
repeat
    print(i)
    i = i + 1
until i > 10
--> 1
--> 2
--> 3
--> 4
--> 5
--> 6
--> 7
--> 8
--> 9
--> 10
print("")

for i = 0, 10 do
    print(i)
    if i == 5 then
        break
    end
end
--> 0
--> 1
--> 2
--> 3
--> 4
--> 5
print("")

for i = 0,10 do
    print(i.."a")
    -- break <= error
    do
        break
    end
    -- ^ safe
    print(i.."b")
end
--> 0a
print("")

function sum(a,b)
    return a + b
end

print (sum(4,6))
--> 10

function reverse(a,b)
    return b,a
end

hoge,hage = reverse(1,2)
print(hoge,hage) --> 2 1
hoge,hage = sum(1,2)
print(hoge,hage) --> 3 nil
print("")

hoge = sum
print("hoge is "..type(hoge)) --> hoge is function
print("4+6 is "..hoge(4,6)) --> 4+6 is 10
print("")

function bar(x)
    local function get()
        return x
    end

    local function add(i)
        x = x + i
    end

    local function remove(i)
        x = x - i
    end

    return get, add, remove
end
oneGet, oneAdd, oneRemove = bar(10)
twoGet, twoAdd, twoRemove = bar(10)
print("oneGet = "..oneGet()) --> oneGet = 10
print("twoGet = "..twoGet()) --> twoGet = 10
oneAdd(15)
twoAdd(40)
print("twoGet = "..oneGet()) --> oneGet = 25
print("twoGet = "..twoGet()) --> twoGet = 50
oneRemove(20)
twoRemove(25)
print("twoGet = "..oneGet()) --> oneGet = 5
print("twoGet = "..twoGet()) --> twoGet = 25
print("")

function makefunc()
    return function(i)
        return i^2
    end
end

func = makefunc()
print("2^2 is "..func(2)) --> 2^2 is 4
print("")

table = {1,2,3}
print(table[1],table[2],table[3]) --> 1 2 3
table = {"a","b","c"}
print(table[1],table[2],table[3]) --> a b c
table = {"a",1}; table[4]=false
print(table[1],table[2],table[3],table[4]) --> a 1 nil false
table = {a=1,b=2,c=3}
print(table["a"],table.a) --> 1 1
a = print
table = {a,
function()
    print("abc")
end,
function(v)
    return v
end}
table[1]("print") --> print
table[2]() --> abc
print(table[3]("vi")) --> vi

table = {"a","b","c"}
table.remove(table, 2)
