require './exercise.rb'

describe 'welcome_message' do
  it 'should return "Hello, World!"' do
    expect(welcome_message).to eq "Hello, World!"
  end
end

describe "factorial" do
  describe "when input = 0" do
    it { expect(factorial 0).to eq 1 }
  end
  describe "when input = 1" do
    it { expect(factorial 1).to eq 1 }
  end
  describe "when input = 2" do
    it { expect(factorial 2).to eq (1*2) }
  end
  describe "when input = 3" do
    it { expect(factorial 3).to eq (1*2*3) }
  end
  describe "when input = 10" do
    it { expect(factorial 10).to eq (1*2*3*4*5*6*7*8*9*10) }
  end
end

describe "factorial_bigger_than" do
  describe "when input = 1" do
    it { expect(factorial_bigger_than 1).to eq 2 }
  end
  describe "when input = 2" do
    it { expect(factorial_bigger_than 2).to eq 6 }
  end
  describe "when input = 10" do
    it { expect(factorial_bigger_than 10).to eq 24 }
  end
  describe "when input = 100" do
    it { expect(factorial_bigger_than 100).to eq 120 }
  end
end

describe "find_longest_string" do
  describe "when input = ['EU', 'US', 'UK', 'BCE']" do
    it { expect(find_longest_string(['EU', 'US', 'UK', 'BCE'])).to eq "BCE" }
  end
  describe "when input = ['dog', 'cat', 'rhino']" do
    it { expect(find_longest_string(['dog', 'cat', 'rhino'])).to eq "rhino"}
  end
end

describe "has_nested_array?" do
  describe "when input = [1, 2, [3, 4]]" do
    it { expect(has_nested_array?([1, 2, [3, 4]])).to be_truthy }
  end
  describe "when input = [[]]" do
    it { expect(has_nested_array?([[]])).to be_truthy }
  end
  describe "when input = [1, 2, 3, 4]" do
    it { expect(has_nested_array?([1, 2, 3, 4])).to be_falsey }
  end
  describe "when input = []" do
    it { expect(has_nested_array?([])).to be_falsey }
  end
end

describe "count_upcased_letters" do
  describe "when input = 'HeLLo'" do
    it { expect(count_upcased_letters('HeLLo')).to eq 3 }
  end
  describe "when input = 'GREETings'" do
    it { expect(count_upcased_letters('GREETings')).to eq 5 }
  end
  describe "when input = 'hola!'" do
    it { expect(count_upcased_letters('hola!')).to eq 0 }
  end
  describe "when input = ''" do
    it { expect(count_upcased_letters('')).to eq 0 }
  end
end
