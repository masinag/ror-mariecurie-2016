
# Ruby Basics 2

# Classes

We define a new class like this

~~~ruby
>> class Word
>> 	def palindrome?(string)
>> 		string == string.reverse
>> 	end
>> end
~~~

and we use it like this

~~~ruby
>> w = Word.new
=> #<Word:0x007fb8759a97e8>
>> w.palindrome? "level"
=> true
~~~

But... it’s odd to create a new class just to create a method that takes a string as an argument, so let's *extend* the Ruby class `String`.

## Extending a Class

We can define `Word` as a subclass of `String`

~~~ruby
>> class Word < String
>> 	def palindrome?
>> 		self == self.reverse
>> 	end
>> end
~~~

`self` is similar to `this` in Java

and now we use it like this

~~~ruby
>> w = Word.new("level")
=> "level"
>> w.palindrome?
=> true
~~~

we obviously inherited all the methods of String

~~~ruby
>> w.length
=> 5
~~~

and we can see the inheritance of our new class

~~~ruby
>> w.class.superclass
=> String
>> w.class.superclass.superclass
=> Object
>> w.class.superclass.superclass.superclass
=> BasicObject
~~~

## Opening a Class

This is something cool of Ruby!

We don't need to extend String to add new methods to it
~~~ruby
>> class String
>>   def palindrome?
>>     self == self.reverse
>>   end
>> end

~~~

and now ladies and gentlemen...

~~~ruby
>> "level".class
=> String
>> "level".palindrome?
=> true
~~~

this is called *opening a built-in class* and you should do it only if you have a **REALLY** good reason.

## Local vs. Instance vs. Class Variables

`x = 3` is a local variable for a method or block (gone when the method is done)

`@x = 3` is a instance variable owned by each object (it sticks around)

`@@x = 3` is a class variable shared by all objects (it sticks around, too).

## Instance vs. Class Methods

Instance methods are defined like this

~~~ruby
>> class Word < String
>> 	def palindrome?
>> 		self == self.reverse
>> 	end
>> end
~~~

and Class methods are defined like this

~~~ruby
>> class Word < String
>> 	def self.palindrome?(s)
>> 		s == s.reverse
>> 	end
>> end
~~~

and you will use it like this

~~~ruby
>> Word.palindrome? "aibohphobia"
=> true
~~~

# Other useful things of Ruby

Ruby has a number of other features that can be really useful, especially when working in Rails

## String interpolation

String interpolation in ruby allows you to embed (the string representation of) a variable in a string

~~~ruby
>> a = 15;
?> "I have #{a} cats"
=> "I have 15 cats"
>> array = [15, 7, 4, 'braai'];
?>   "this is an array: #{array}"
=> "this is an array: [15, 7, 4, \"braai\"]"
>> "The time now is #{Time.now}"
~~~

## Ruby Gems

Gems are software packages that include software or libraries that can be used in your Ruby code to add functionalities and behaviors

Rails itself is a Ruby Gem, and you should have it installed already

~~~bash
gem list | grep rails
rails -v
~~~

## Ruby Assignments

Ruby has the `||` operator which is a bit funky. When put in a chain

~~~ruby
x = a || b || c || "default"
~~~

it means “test each value and return the first that’s not false.” So if `a` is false, it tries `b`. If `b` is false, it tries `c`. Otherwise, it returns the string `"default"`.

If you write

~~~ruby
x = x || "default"
~~~

it means “set `x` to itself (if it has a value), otherwise use the `"default"`.” An easier way to write this is

~~~ruby
x ||= "default"
~~~

which means the same: set x to the default value unless it has some other value. You’ll see this a lot in Ruby code.

## Syntax: parenthesis and semicolons

* Parenthesis on method calls are optional; use `print "hi"`.
* Semicolons aren't needed after each line.
* Use “if do else end” rather than braces.
* Parens aren't needed around the conditions in if-then statements.
