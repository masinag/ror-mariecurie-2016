# Author deve avere getters e setters per name e surname
class Author
  attr_accessor :name, :surname
end

=begin
Product deve avere un metodo :valid? che verifica che:
* name è una stringa non vuota
* producer è una stringa non vuota
* code è una stringa di 6 caratteri
* price è > 0
=end
class Product
  attr_accessor :name, :producer, :code, :price

  def valid?
    not name.empty? and not producer.empty? and code.length == 6 and price > 0
  end
end

=begin
Person deve avere due metodi:
* bmi: ritorna il BMI basato sul peso e l'altezza
* bmi_category: ritorna la categoria di BMI sulla base di BMI_CATEGORIES
=end
class Person
  BMI_CATEGORIES = {
    very_severely_underweight: 0.0...15.0,
    severely_underweight: 15.0...16.0,
    underweight: 16.0...18.5,
    healthy_weight: 18.5...25.0,
    overweight: 25.0...30.0,
    obese: 30.0...35.0,
    severely_ovbese: 35.0...40.0,
    very_severely_obese: 40.0...999999.99999
  }
end
