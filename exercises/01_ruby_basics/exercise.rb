# Return a string of greeting
def welcome_message
  "Hello, World!"
end

# Implement the factorial function
def factorial(n)
  (1..n).inject(1){ |res, el| res * el }
end

# Find the first factorial number greater than m
def factorial_bigger_than(m)
  (1..1000).each {|n| return factorial(n) if factorial(n) > m}
end

# Find the longest string in an array
def find_longest_string(array)
  false
end

# Find if an array has nested arrays in it
def has_nested_array?(array)
  false
end

# Count the number of upcased letters in a string
def count_upcased_letters(string)
  false
end
