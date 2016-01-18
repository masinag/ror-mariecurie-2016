require './exercise.rb'

def test_welcome_message
  assert_equal "Hello, World!", welcome_message
end

def test_factorial
  assert_equal 1, factorial(1)
  assert_equal 2, factorial(2)
  assert_equal 9, factorial(3)
  assert_equal 3628800, factorial(10)
end

def test_factorial_bigger_than
  assert_equal 2, factorial_bigger_than(1)
  assert_equal 6, factorial_bigger_than(2)
  assert_equal 24, factorial_bigger_than(10)
  assert_equal 120, factorial_bigger_than(100)
end

def test_find_longest_string
  assert_equal "BCE", find_longest_string(["EU", "US", "UK", "BCE"])
  assert_equal "rhyno", find_longest_string(["dog", "cat", "rhyno"])
end

def test_hash_nested_array
  assert has_nested_array?([1, 2, [3, 4]])
  assert has_nested_array?([[]])
  refute has_nested_array?([1, 2, 3, 4])
  refute has_nested_array?([])
end

def test_count_upcased_letters
  assert_equal 3, count_upcased_letters("HeLLo")
  assert_equal 5, count_upcased_letters("GREETings")
  assert_equal 0, count_upcased_letters("hola!")
  assert_equal 0, count_upcased_letters("")
end

# this is used by all the tests
def assert(t)
  t or raise Exception, "Assertion failed"
end

def assert_equal(p, q)
  assert p == q
end

def refute(f)
  assert !f
end

# run all the methods that match /test/
private_methods.grep(/test/).each { |m|
  send(m)
  puts "#{m.to_s} was successful!"
}

puts "All the tests passed! Good job!"
