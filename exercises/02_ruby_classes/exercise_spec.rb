require './exercise.rb'

RSpec.configure do |config|
  config.mock_with :rspec
end

RSpec.shared_examples 'when a product is invalid' do
  it 'should return false' do
    # expect(@product).to respond_to(:valid?).with(false)
    expect(product.valid?).to eq false
  end
end

describe Author do
  let(:author) { Author.new }

  it 'should have attribute accessors for name and surname' do
    expect(author).to respond_to(:name=, :surname=, :name, :surname)
  end

end

describe Product do
  let(:product) { Product.new }

  before do
    allow(product).to receive_messages(
      name: 'Cassetta frutta e verdura di stagione',
      producer: 'Azienda Agricola Voltolini Debora',
      code: 'xyz010',
      price: 10.50,
    )
  end

  context "#valid?" do
    context "when the product's name is empty" do
      before do
        allow(product).to receive(:name).and_return('')
      end
      it_behaves_like 'when a product is invalid'
    end
    context "when the product's producer is empty" do
      before do
        allow(product).to receive(:producer).and_return('')
      end
      it_behaves_like 'when a product is invalid'
    end
    context "when the product's code is 'abcddajghal13215yq122'" do
      before do
        allow(product).to receive(:code).and_return('abcddajghal13215yq122')
      end
      it_behaves_like 'when a product is invalid'
    end
    context "when the price is -19" do
      before do
        allow(product).to receive(:price).and_return(-19)
      end
      it_behaves_like 'when a product is invalid'
    end

    context "when a product is valid" do
      it 'should return true' do
        expect(product.valid?).to eq true
      end
    end
  end



end

describe Person do
  let(:person) { Person.new(1.8, 80.0) }

  it 'should be created with height and weight parameters' do
    expect { person }.not_to raise_error
  end

  context "#bmi" do
    it 'should return a person\'s BMI (weight / (height**2))' do
      expect(person.bmi).to eq(80.0 / (1.8 ** 2))
    end
  end

  context "#bmi_category" do
    Person::BMI_CATEGORIES.each do |key, bmicat|
      bmi = rand(bmicat)
      context "when BMI = #{bmi}" do
        it "should return #{key}" do
          allow(person).to receive(:bmi).and_return(bmi)
          expect(person.bmi_category).to eq(key)
        end
      end
    end
    it 'should return :healthy_weight when height=1.8 and weight=80.0' do
      expect(person.bmi_category).to eq(:healthy_weight)
    end
  end

end
