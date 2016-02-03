class Author
end

class Product
end

class Person
  BMI_CATEGORIES = {
    very_severely_underweight: 0.0...15.0,
    severely_underweight: 15.0...16.0,
    underweight: 16.0...18.5,
    healthy_weight: 18.5...25.0,
    overweight: 25.0...30.0,
    obese: 30.0...35.0,
    severely_ovbese: 35.0...40.0,
    very_severely_obese: 40.0...Float::INFINITY
  }
end
