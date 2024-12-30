--[[
Lua is a dynamically typed language. This means that variables do not have types; only values do. There are no type definitions in the language. All values carry their own type.
All values in Lua are first-class values. This means that all values can be stored in variables, passed as arguments to other functions, and returned as results.
]] local function ch2 ()

a = nil -- nil
a = true -- boolean
-- nil is often used instead of false; see L15
-- nil and false are false values, all others ret true
a = -1.3 -- number
a = "Hello W\0rld" -- string
-- userdata allows c <-> lua. only in c
a = function(a,b,c,...) end -- function
-- thread allows coroutines
a = {} -- table
-- in tables, nil means empty, and vice versa
a.name = 1; a["name"] = 2 -- a.name is 2
a[3.0] = 3 -- a[3] is 3
a = {[2] = 2} -- a[2] is 2

print(type(a)) -- returns a string

function foo (a)
print("foo", a)
return coroutine.yield(2*a)
end
co = coroutine.create(function (a,b)
print("co-body", a, b)
local r = foo(a+1)
print("co-body", r)
local r, s = coroutine.yield(a+b, a-b)
print("co-body", r, s)
return b, "end"
end)
print("main", coroutine.resume(co, 1, 10))
print("main", coroutine.resume(co, "r"))
print("main", coroutine.resume(co, "x", "y"))
print("main", coroutine.resume(co, "x", "y"))
-- i kinda get it?
end
--[[
Lua is a free-form language. It ignores spaces and comments between lexical elements (tokens), except as delimiters between two tokens. In source code, Lua recognizes as spaces the standard ASCII whitespace characters space, form feed, newline, carriage return, horizontal tab, and vertical tab.
]] local function ch3_1 ()

--[[
reserved stuff:
and break do else elseif end false for function goto if in local nil not or repeat return then true until while
+ - * / % ^ # & ~ | << >> // == ~= <= >= < > = ( )
{ } [ ] :: ; : , . .. ...
]]

_BINGLEBOB = "BINGL\x33B\32B\z
" -- \z is an escazpe character
-- bad: the same convention is used for other important vars, like _VERSION
print(_BINGLEBOB) -- DECIMAL ascii 32 is space

a = [=====[
hel\t[o]
i guess
]=====] -- note the newlines
print(a)

a = 1e12 -- quadrillion
a = 0x5f3759df -- that one number
a = 0x1.fp10 -- 1984
print(a) -- proof

a = 0x1.921fb54442d18p+1
print(a) -- i have no words, lua documentation

a = {print(1);print(2)} -- it says i can do ;; and {;...}, but i can't?

a = 1
a = 1 + a
;(print)(1) -- needed, or else will call a(print)(1)

do print("do end") end

a, _BINGLEBOB = {8, 5, 9}, 2
_BINGLEBOB, a[_BINGLEBOB] = _BINGLEBOB+1, _BINGLEBOB+1
print(a[1], a[2], a[3]) -- {8, 3, 9} as opposed to {8, 5, 4}
end function ch3_2 ()

a = 0
while a < 3 do
	a = a + 1
end

repeat
	a = a + 1
	break
until a > 7

::dengo::

if a == 8 then 
	a = a + - 1
elseif a == 7 then 
	a = a + 1
	print("from 7 to...")
else 
	a = a + 1
	goto dengo
end
print(a) -- 8

for i = 0, 10, 2 do 
	print(i)
end

do
	local b = 3 -- or local b;b=3
	print("b", b)
end

end local function ch3_3 ()
-- + - * / % and unary - (-3) are as is
a = 3^2 -- 9
-- & | >> << are obvious
-- ~ when binary is xor, when unary is not???
-- all bitwise ops convert to ints

-- == < > <= >= are as is
-- ~= is negation of ==

--[[ strings and numbers are ok, but
tables userdata & functions are only equal if they
are the same object, so e.g.
a={1,2,3};b=a;a==b is false
]]

--[[
The negation operator not always returns false or true. The conjunction operator and returns its first argument if this value is false or nil; otherwise, and returns its second argument. The disjunction operator or returns its first argument if this value is different from nil and false; otherwise, or returns its second argument. Both and and or use short-circuit evaluation; that is, the second operand is evaluated only if necessary. Here are some examples:
]]

print(
	10 or 20,
	10 or error(),
		nil or 10,
	nil and 10,
	false and error(),
	false and nil,
	false or nil,
	10 and 20
)

print(1 .. 2, "a" .. "b", "a" .. 1)

end --[[
The length operator applied on a table returns a border in that table. A border in a table t is any non-negative integer that satisfies the following condition:
(border == 0 or t[border] ~= nil) and
(t[border + 1] == nil or border == math.maxinteger)
In words, a border is any positive integer index present in the table that is followed by an absent index, plus two limit cases: zero, when index 1 is absent; and the maximum value for an integer, when that index is present. Note that keys that are not positive integers do not interfere with borders.
A table with exactly one border is called a sequence. For instance, the table {10, 20, 30, 40, 50} is a sequence, as it has only one border (5). The table {10, 20, 30, nil, 50} has two borders (3 and 5), and therefore it is not a sequence. (The nil at index 4 is called a hole.) The table {nil, 20, 30, nil, nil, 60, nil} has three borders (0, 3, and 6), so it is not a sequence, too. The table {} is a sequence with border 0. When t is a sequence, #t returns its only border, which corresponds to the intuitive notion of the length of the sequence. When t is not a sequence, #t can return any of its borders. (The exact one depends on details of the internal representation of the table, which in turn can depend on how the table was populated and the memory addresses of its non-numeric keys.)
]]

--[[
Operator precedence in Lua follows the table below, from lower to higher priority:
or
and
< > <= >= ~= ==
|
~
&
<< >>
..
+ -
* / // %
unary operators (not # - ~)
^
As usual, you can use parentheses to change the precedences of an expression. The concatenation ('..') and exponentiation ('^') operators are right associative. All other binary operators are left associative.
]] 
--[[
The statement
function f () body end
translates to
f = function () body end
The statement
function t.a.b.c.f () body end
translates to
t.a.b.c.f = function () body end
The statement
local function f () body end
translates to
local f; f = function () body end
not to
local f = function () body end
(This only makes a difference when the body of the function contains references to f.)
]] local function ch3_4 ()

function a(x, y, ...) print(x, y, ...) end
local function b(x, y) print(x, y) end
local function c() return 7, 8, 9 end

	b(3) b(3, 4) b(3, 4, 5) b(c(), 'a')
	a(3) a(3, 4) a(3, 4, 5, 8)
	a(c(), 'a') a('a', c())

--[[
The colon syntax is used to emulate methods, adding an implicit extra parameter self to the function. Thus, the
statement
function t.a.b.c:f (params) body end
is syntactic sugar for
t.a.b.c.f = function (self, params) body end
]] end local function ch3_5 ()

a = {}
local x = 20
for i = 1, 10 do
local y = 0
a[i] = function () y = y + 1; return x + y end
end
print(a[1](), a[2](), a[3](), a[4]()) --[21]*4

--[[The loop creates ten closures (that is, ten instances of the anonymous function). Each of these closures uses a different y variable, while all of them share the same x.]] end
local function ch6()
	--some useful ones
	a = 1
	print(assert(a == 1), '<- true')
	--assert(a == 2, 'uh oh')
	--dofile(idk.lua) -- executes the file, if no arg uses stdin
	--error('aw man', 3) -- errors out, and points to the function (3) that called the function (2) that called it (1)
	print(getmetatable('a')) --kinda like python's dir()
	a = {4, 2, 0}
	for i,v in ipairs(a) do print(i,v) end
	--kinda like python's enumerate()
	print(load('print("loaded")')()) --evals strings
	--first \n is from loadprint, second is from print
	print( next(a, 1), next(a), next({}) )
	--best used to check if table is empty
	print(pcall(error, 'oops'))--like try-catch, first item is if it runs succsessfully
	--tostring(1) --formats into human-readable
	--tonumber("A", 16) returns 10 (16rA by the way)
	print(_VERSION, os.clock())
	print(_G) --code ran, doesn't modify the file
	a = 'tis\' _ENV.a'; print(_ENV.a)
	--[[
	see also:
	coroutine, package, string, utf8, table, math,
	io, os, and debug
	]]
end ch6()
