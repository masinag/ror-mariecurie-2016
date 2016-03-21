class Profile

  attr_accessor :name, :surname, :registration_date

  def valid?
    errors.empty?
  end

  def errors
    e = []
    e << :registration_date unless registration_date.is_a? Date
    [:name, :surname].each do |att|
      e << att unless send(att).is_a?(String) and not_empty?(send(att)) and valid_length?(send(att)) and valid_characters?(send(att))
    end
    e
  end

  private

  def not_empty? s
    not s.empty?
  end

  def valid_length? s
    (s.length >= 2) and (s.length <= 64)
  end

  def valid_characters? s
    not /^[A-Z][a-z]+$/.match(s).nil?
  end

end

class Problem

  def self.min_uppercase(input)
    input.inject(nil) { |acc, s| acc = s if acc.nil? || (count_uppercase(s) < count_uppercase(acc)); acc }
  end

  def self.max_depth(input)
    unless input.is_a? Array
      return 0
    else
      depth_of(input)
    end
  end

  private

  def self.count_uppercase s
    s.scan(/[A-Z]/).size
  end

  def self.depth_of a
    a.inject(1) { |acc, i| i.is_a?(Array) ? acc + depth_of(i) : acc }
  end

end
