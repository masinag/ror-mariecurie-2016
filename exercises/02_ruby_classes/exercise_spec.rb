require './exercise.rb'

describe Author do
  it 'has attribute accessors' do
    author = Author.new
    author.name = 'William'
    author.surname = 'Shakespeare'
    exepect(author.name).to eq 'William'
    exepect(author.surname).to eq 'Shakespeare'
  end
end

describe Product do
  it 'recognize valid products' do
    validprod = Product.new
    validprod.name = 'Cassetta frutta e verdura di stagione'
    validprod.producer = 'Azienda Agricola Voltolini Debora'
    validprod.code = 'xyz010'
    validprod.price = 10.50
    expect(validprod.valid?).to be true
  end

  it 'recognize invalid products' do
    invalidprod = Product.new
    expect(invalidpord.valid?).to be false
  end
end

describe Person do
  it 'has attribute accessors' do
    person = Person.new(1.8, 80.0)
    exepect(person.height).to eq 1.8
    exepect(person.weight).to eq 80.0
    person.height = 1.95
    person.weight = 75.0
    expect(person.height).to eq 1.95
    exepect(person.weight).to eq 75.0
  end

  it 'has a bmi method' do
    person = Person.new(1.8, 80.0)
    expect(person.bmi).to eq(80.0 / (1.8 ** 2))
  end

  it 'has a bmi_category method' do
    person = Person.new(1.8, 80.0)
    expect(person.bmi_category).to eq :healthy_weight
  end
end
