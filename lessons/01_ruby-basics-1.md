# Ruby Basics 1

## The console

Just type `irb` in your command shell and you should see something like

~~~ruby
irb(main):001:0>
~~~

`irb` is the *Interactive Ruby Shell*.

Type `irb --prompt simple` for a shorter prompt

~~~ruby
>>
~~~

## The classic `Hello World`

When you learn a new language you always write the same Hello World program

~~~ruby
>> puts "Hello World!" # done!
~~~

# Numbers

Ruby recognizes numbers and mathematic symbols.

~~~ruby
>> 4+3
=> 7
>> 4-5
=> -1
>> 42/6
=> 7
>> 6*7
=> 42
>> 2**10
=> 1024
~~~

# Strings

To make a `String` just enclose the text in quotes

~~~ruby
>> "Valsugana"
=> "Valsugana"
~~~

## Play with strings

let's try to reverse it

~~~ruby
>> "Valsugana".reverse
=> "anaguslaV"
~~~

how long is Valsugana?

~~~ruby
>> "Valsugana".length
=> 9
~~~

let's repeat it

~~~ruby
>> "Valsugana" * 5
=> "ValsuganaValsuganaValsuganaValsuganaValsugana"
~~~

or SHOUT it out loud

~~~ruby
>> "Valsugana".upcase
=> "VALSUGANA"
~~~

# Methods

`reverse` and `*` are methods!

The correct term is actually *messages*

~~~ruby
>> 4.send(:+, 3)
=> 7
~~~

here we send the message `:+` with parameter 3 to the object 4

## Wrong methods

~~~ruby
>> 42.reverse
NoMethodError: undefined method 'reverse' for 42:Fixnum
~~~

Ruby is telling us there is no method reverse for numbers.
but we can do something like this

~~~ruby
>> 42.to_s.reverse
=> "24"
~~~

or this

~~~ruby
>> 42.to_s.reverse.to_i
=> 24
~~~

# Arrays

What are arrays?! They are **lists**.
Type in a pair of brackets: `[]`

~~~ruby
>> [12, 78, 27]
=> [12, 78, 27]
~~~

Lists store elements in the order they are inserted.

## Have fun with arrays

~~~ruby
>> [12, 78, 27].max
=> 78
>> [12, 78, 27].last
=> 27
>> [12, 78, 27].reverse
=> [27, 78, 12]
>> [12, 78, 27].sort
=> [12, 27, 78]
~~~

# Arrays and strings
a `String` can be seen as an array of `chars`

~~~ruby
>> "Valsugana".chars.to_a
=> ["V", "a", "l", "s", "u", "g", "a", "n", "a"]
>> "Valsugana".chars.to_a.reverse
=> ["a", "n", "a", "g", "u", "s", "l", "a", "V"]
>> "Valsugana".chars.to_a.reverse.join
=> "anaguslaV"
>> "Valsugana".reverse
=> "anaguslaV"
~~~

# Variables
Variables save a thing and give it a name.

We use the equals sign to do this.

~~~ruby
>> nums = [20, 5, 1, 100, 8, 13, 0.5, 40, 2, 3, 0]
=> [20, 5, 1, 100, 8, 13, 0.5, 40, 2, 3, 0]
~~~

We can call methods on variables (i.e. send them *messages*)

~~~ruby
>> nums.sort!
=> [0, 0.5, 1, 2, 3, 5, 8, 13, 20, 40, 100]
~~~

# What's that `!`?
The exclamation at the end means that the method `sort!` changes what the variable contains for good.

So, after `nums.sort!`:

~~~ruby
>> nums
=> [0, 0.5, 1, 2, 3, 5, 8, 13, 20, 40, 100]
~~~

Note that this is only a convention!

## There is also the `?`

~~~ruby
>> nums.include? 42
=> false
>> nums.include? 13
=> true
>> nums.include? "∞"
=> false
>> nums.empty?
=> false
~~~

This is a convention too!

# The `:symbols`

When you place a colon in front of a simple word, you get a symbol.

Symbols are cheaper than strings (in terms of computer memory.) If you use a word over and over in your program, use a symbol. Rather than having thousands of copies of that word in memory, the computer will store the symbol only once.

Symbols are useful for indexing *hashes*.

# Hash

Namely a list of `key-value` pairs.

a.k.a. `Dictionary`, `HashTable`, `HashMap`, ...

## Java `HashTable`

~~~java
// create the HT
Hashtable<String, Integer> numbers = new Hashtable<String, Integer>();

// fill the HT
numbers.put("one", 1);
numbers.put("two", 2);
numbers.put("three", 3);

// access the HT
Integer n = numbers.get("two");
if (n != null) {
 System.out.println("two = " + n);
}
~~~

## Ruby `Hash`

~~~ruby
# create the hash
>> numbers = {}

# fill the hash
>> numbers["one"] = 1
>> numbers["two"] = 2

# access the hash
>> numbers["two"]
=> 2
>> numbers["fortytwo"]
=> nil
~~~

## Play with hashes

Let's create a new hash of our favourite food

~~~ruby
>> food = {}
=> {}
~~~

a hash is a set of `key => value` pairs, unordered

~~~ruby
>> food["Pizza"] = :molto_buono
=> :molto_buono
>> food
=> {"Pizza"=>:molto_buono}
~~~

let's add a few

~~~ruby
>> food["Carciofi"] = :non_buono
=> :non_buono
>> food["Salsiccia"] = :molto_buono
=> :molto_buono
>> food["Pajata"] = :non_so
=> :non_so
>> food["Mozzarella"] = :buono
=> :buono
>> food["Aragosta"] = :ottimo
=> :ottimo
~~~

and see how many

~~~ruby
>> food
=> {"Pizza"=>:molto_buono, "Carciofi"=>:non_buono, "Salsiccia"=>:molto_buono, "Pajata"=>:non_so, "Mozzarella"=>:buono, "Aragosta"=>:ottimo}
>> food.length
=> 6
~~~

Let's have a look to our ratings: create a hash for storing the rates

~~~ruby
>> recensioni = Hash.new(0)
=> {}
~~~

and fill it with our recensioni of food

~~~ruby
>> food.values.each { |voto| recensioni[voto] += 1 }
~~~

here it is

~~~ruby
>> recensioni
=> {:molto_buono=>2, :non_buono=>1, :non_so=>1, :buono=>1, :ottimo=>1}
~~~

**what's that `{|| ...}`?**

# Ruby *blocks*

That piece of code is called a *block* and that's how it works

~~~ruby
>> food.values.each { |voto| recensioni[voto] += 1 }
~~~

`|voto|` is the *block variable*

`recensioni[voto] += 1` is the *block code*

each value of `food` is put into the *block variable* and the *block code* is executed.

## Multi-line block
When you have a huge block you can write it using multiple lines

~~~ruby
>> food.values.each do |voto|
?> 	recensioni[voto] += 1
>> end
>> recensioni
=> {:molto_buono=>2, :non_buono=>1, :non_so=>1, :buono=>1, :ottimo=>1}
~~~

`do` and `end` work for `{...}`

# Control flow

namely `if`, `then`, `else` stuff

~~~ruby
>> s = "a string"
>> if s.empty? then
>>   "The string is empty"
>> else
>>   "The string is nonempty"
>> end
=> "The string is nonempty"
~~~

you can omit `then`, its not mandatory.
However, sometimes you might have lot of cases

~~~ruby
>> s = "a string"
>> if s.empty? then
>>   "The string is empty"
>> elsif s.length < 4
>>   "The string is nonempty and its length is less than 4"
>> elsif s.length == 4
>>   "The string is nonempty and its length is 4"
>> else
>>   "The string is nonempty and its length is more than 4"
=> "The string is nonempty and its length is more than 4"
~~~

we can also use `unless`

~~~ruby
>> x = "a variable"
>> puts "x is not empty" if !x.empty?
x is not empty
=> nil
>> puts "x is not empty" unless x.empty?
x is not empty
=> nil
~~~

Note that the condition can also be put *after* the code to execute.

# The `nil` object

`nil` is a special object, similar to the Java `null`

it is the only Ruby object that is `false` in a boolean context, apart from `false` itself

~~~ruby
>> if nil
>> 	true
>> else
?> 	false
>> end
=> false
~~~

all other Ruby objects are true, even 0

~~~ruby
>> if 0
>> 	true
>> else
?> 	false
>> end
=> true
~~~

# Loops

Things like `for` and `while`. They exist in Ruby but we like the others!

## The `each` method

Executes the *block code* on all the elements of `self`

~~~ruby
>> (1..5).each do |element|
?> 	print element * 10, " "
>> end
10 20 30 40 50                  
~~~

## The `map` method

Invokes the given *block code* once for each element of `self` and creates a new array containing the values returned by the block

~~~ruby
>> (1..5).map do |element|
?>   element * 2
>> end
=> [2, 4, 6, 8, 10]
~~~

## The `select` method

It is like `map` but returns only the elements that match the condition

~~~ruby
>> (1..5).select do |element|
?>   element.even?
>> end
=> [2, 4]
~~~

# Method definition

Open the definition with `def` and close it with `end`

~~~ruby
>> def palindrome?(string)
>>  string == string.reverse
>> end
~~~

and call it by name

~~~ruby
>> palindrome? "level"
=> true
~~~

in Ruby functions have an implicit *return*, meaning they *return* the last statement evaluated, but don't worry, the `return` statement exists too.
