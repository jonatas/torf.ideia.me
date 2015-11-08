# True is true?

true == true

true == false

true != false

true and false == false

true && false == false

false || true == true

"" == nil

# Operators

nil.nil?

!nil

!false

!!false

!!!!!false

## Selectors

[1,2,3,4,5][2,1] == [3]

[1,2,3,4,5][2,2] == [3,4]

"abcd"[1,2] == "bc"

"abcd"[1..2] == "bc"

"abcd"[-2..-1] == "bc"

"abcdefg"[/^abc/].nil?

"abcdefgh"[/defghij/].nil?

[1,[2,[3,[4],-3],-2],-1][1][1][1] == [4]

"@jonatasdp"[/@(.*)/,1] == 'jonatasdp'

"x@y.z"[/(.*)@(.*)/,2] == 'y.z'

(2..3).to_a - (2..3).to_a == [3]

## Comparators

1 == 1 

1 > 1

2 > 3

2 < 1

"abc".tr('abc','x') == 'xxx'

## Xunda stuff

# Regex

"x"[/x/].nil?

( %\|\ =~ /|/ ) == 0

('o/|\o' =~ %r{o/}) > 0

# Crazy Syntaxes

%i(a b) == ['a', 'b']

%i(()) != [:"()"]

%w(a b) == ["a", "b"]

%w(a b) * 2 == ["a", "b", "a", "b"]

%|x| == %{x}

%\|\ == %/|/

%|| == ""

"o/ " " \o" == "o/  \o"

## Crazy shortcuts

$:.is_a? Array

## Classes comparison

Integer > Numeric

Integer < Numeric

Time < Object

Integer < Float == true

## Bitwise some stuff

   # if you need some [help](http://www.calleerlandsson.com/2014/02/06/rubys-bitwise-operators/)?

true & false

true | false

false | true

true & false

true | false

false & true

## 0 || 1 area

0 & 1 == 0

1 | 0 == 1

1 & 0 == 1

1 & 0 == 0

1 | 0 == 0

1 | 0 == 0

# Array

Array(a: "a", b: "b") == [[:a, "a"], [:b, "b"]]

Array(a: "a", b: "b") == [[:a, "a"], [:b, "b"]]

Array.new(2, true) == [true,true]

Array.new(4).length == 4

Array.new(4).compact.length == 4

# String

"#{"a"}" == '"a"'

'#{"a"}' == '"a"'

'b'*3 == 'bbbb'

"á".bytes.size == 1

# Functional stuff

(1..5).to_a
  .select {|e| e % 2 == 0}
  .send :==, [2, 4]

(1..5).to_a
  .select {|e| e % 2 == 0}
  .map {|e| e * e / 4}
  .reverse
  .send :==, [1, 4]

# Floating fails

1e2 == 10

1e3 == 100.0

1e2 * 1e2 == 1e3
