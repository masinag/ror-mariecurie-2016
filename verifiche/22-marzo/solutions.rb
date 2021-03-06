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
    # input.inject(nil) { |acc, s| acc = s if acc.nil? || (count_uppercase(s) < count_uppercase(acc)); acc }
    input.min { |a,b| count_uppercase(a) <=> count_uppercase(b) }
  end

  def self.max_depth(input)
    unless input.is_a? Array
      return 0
    else
      (input.map { |i| max_depth(i) }.max || 0) + 1
    end
  end

  private

  def self.count_uppercase s
    s.scan(/[A-Z]/).size
  end

end
