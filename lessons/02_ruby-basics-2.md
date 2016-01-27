
# Ruby Basics 2

# Classes

A class in Ruby is a collection of methods. The name of a class always starts with an upper case letter.

~~~ruby
class Person

end
~~~

In order to create a new object (an instance) of the class Person you have to write `Person.new`.

~~~ruby
p1 = Person.new
puts p1
p2 = Person.new
puts p2
~~~

As you can see, `p1` and `p2` are two different objects! Be aware of this...
~~~ruby
puts p1 == p2
~~~

When a new instance is created, the initialize method is called!
~~~ruby
class Person
  def initialize
    puts "Hey!"
  end
end

p = Person.new
~~~

Lets try to add one method more..
~~~ruby
class Person
  def initialize
    puts "Hey!"
  end
  def hello
    puts "Hello!"
  end
end
~~~

And now, lets call it!

~~~ruby
p = Person.new
puts p.hello
puts p.nil?
puts p.class
~~~

What happened? `.class` and `.nil?` are methods! We did not define them! How is it possible?
The answer is simple, each class in Ruby has a basic set of default methods! You can use the `instance_methods` method in order to explore them. Use it with the `false` parameter if you want to see only those you defined.

~~~ruby
puts Person.instance_methods
puts Person.instance_methods(false)
~~~

Often it makes sense to call a method within its own class. Such methods are referred to as private methods and have to be written below the keyword `private`. The same in case of `protected` methods. Of course, if a private method is called outside the class, an error occurs.
~~~ruby
class Person
  def initialize
    puts "Hey!"
  end

  private
  def hello
    puts "Hello!"
  end
end

p = Person.new
puts p.hello # Error!
~~~

## Class methods and instance methods

Ruby allows you to write class methods and instance methods. The difference between the two is that class methods are defined with the keyword `self` as follows. The keyword `self` is similar to `this` in Java.

~~~ruby
class Person
  def initialize
    puts "Hey!"
  end
  # This is an instance method
  def hello
    puts "Hello!"
  end
  # This is a class method
  def self.hello
    puts "Ciao!"
  end
end
~~~

We have already seen how to call an instance method. However, in order to call a class method you need to call it on the class.

~~~ruby
p = Person.new
puts p.hello        # Hello!
puts Person.hello   # Ciao!
~~~


## Local variables, class variables and instance variables

Usually variables are written with lower case while constants are written in upper case.

~~~ruby
variable = "This is a variable"
CONSTANT = "This is a constant"
~~~

With the `@` symbol you can define instance variables (e.g. `@name`). An instance variable might assume different values among different instances. However, with no other methods it is not yet accessible.
With the `@@` symbol you can define class variables (e.g.  `@@color`). A class variable is shared (have the same value) among all objects (instanes).

~~~ruby
class Person
  def initialize
    @name = "Giovanni"
  end
end

p = Person.new
puts p.name # Error!
~~~

In order to access instance variables, define getter and setter methods.

~~~ruby
class Person
  def initialize
    @name = "Giovanni"
  end

  # Getter
  def name
    @name
  end

  # Setter
  def name=(name)
    @name = name
  end
end

p = Person.new
puts p.name
puts p.name="Alberto"
puts p.name
~~~

Of course, Ruby has a smart way to do it! Use `attr_reader`, `attr_writer` or combine both with `attr_accessor` instead!

~~~ruby
attr_reader :name, :surname
attr_writer :name, :surname

# Combine attr_reader and attr_writer
attr_accessor :name, :surname
~~~

In addition, define also a `to_s` method in order to be able to print you own instance!

~~~ruby
class Person

  attr_accessor :name

  def initialize
    @name = "Giovanni"
  end

  def to_s
    "Hi! My name is #{@name}."
  end
end
~~~

What is `#{@name}`? It is a shortcut that allows you to take the value of the variable `@name` and put it inside a string. In Ruby it is called String interpolation.

~~~ruby
a = 15;
puts "I have #{a} cats"
=> "I have 15 cats"
array = [15, 7, 4, 'braai'];
puts "this is an array: #{array}"
=> "this is an array: [15, 7, 4, \"braai\"]"
~~~

## More advance stuff, class again

Lets define the class `Word` as follows.

~~~ruby
class Word
	def palindrome?(string)
		string == string.reverse
	end
end
~~~

Now create an new instance and call the palindrome on it.

~~~ruby
w = Word.new
puts w.palindrome? "level" # true
~~~

But... it’s odd to create a new class just to create a method that takes a string as an argument, so let's *extend* the Ruby class `String`.

## Extending a Class

We can define `Word` as a subclass of `String`

~~~ruby
class Word < String
	def palindrome?
		self == self.reverse
	end
end
~~~

~~~ruby
w = Word.new("level")
puts w.palindrome? # true
~~~

We obviously inherited all the methods of String..

~~~ruby
puts w.length
=> 5
~~~

and we can see the inheritance of our new class

~~~ruby
puts w.class.superclass
=> String
puts w.class.superclass.superclass
=> Object
puts w.class.superclass.superclass.superclass
=> BasicObject
~~~

## Opening a Class

This is something cool of Ruby!

We don't need to extend String to add new methods to it
~~~ruby
class String
  def palindrome?
    self == self.reverse
  end
end

~~~

and now ladies and gentlemen...

~~~ruby
>> "level".class
=> String
>> "level".palindrome?
=> true
~~~

This is called *opening a built-in class* and you should do it only if you have a **REALLY** good reason.

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
