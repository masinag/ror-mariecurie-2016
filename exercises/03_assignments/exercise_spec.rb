require 'date'
require './exercise.rb'
#require './solutions.rb'

RSpec.configure do |config|
  config.mock_with :rspec
end

describe Point2D do
  let(:x) { 1.0 }
  let(:y) { 2.0 }
  let(:point) { Point2D.new(x,y) }

  it 'should have attribute accessors for x and y' do
    expect(point).to respond_to(:x, :y)
    expect(point.x).to eq x
    expect(point.y).to eq y
  end

  it 'should not have attribute writers for x and y' do
    expect(point).not_to respond_to(:x=, :y=)
  end

  it 'should have a `+` method' do
    point1 = point + point
    expect(point1.x).to eq(x + x)
    expect(point1.y).to eq(y + y)
  end

  it 'should not change state when using the `+` method' do
    point + point
    expect(point.x).to eq x
    expect(point.y).to eq y
  end

  it 'should have a to_s method' do
    expect(point.to_s).to eq "(#{x},#{y})"
  end
end

describe Book do
  shared_examples 'when a book is invalid' do
    it 'should return false' do
      expect(book.valid?).to eq false
    end

    it 'should have a non-empty errors array' do
      expect(book.errors.empty?).to eq false
    end
  end

  let(:book) { Book.new }

  before do
    book.title = 'Giulio Cesare'
    book.author = 'Shakespeare'
    book.release_date = Date.new(1599,1,1)
    book.publisher = 'Tascabili Economici Newton'
    book.isbn = 8879839934
  end

  context "#valid?" do
    # XXX can you DRY this up?
    context "when a book is valid" do
      it 'should return true' do
        expect(book.valid?).to eq true
      end
    end
    context "when the book's title is empty" do
      before do
        book.title = ''
      end
      it_behaves_like 'when a book is invalid'
    end
    context "when the book's title is not a string" do
      before do
        book.title = 12
      end
      it_behaves_like 'when a book is invalid'
    end
    context "when the book's author is empty" do
      before do
        book.author = ''
      end
      it_behaves_like 'when a book is invalid'
    end
    context "when the book's author is not a string" do
      before do
        book.author = 12
      end
      it_behaves_like 'when a book is invalid'
    end
    context "when the book's release_date is not a date" do
      before do
        book.release_date = 12
      end
      it_behaves_like 'when a book is invalid'
    end
    context "when the book's publisher is empty" do
      before do
        book.publisher = ''
      end
      it_behaves_like 'when a book is invalid'
    end
    context "when the book's publisher is not a string" do
      before do
        book.publisher = 12
      end
      it_behaves_like 'when a book is invalid'
    end
    context "when the book's ISBN is nil" do
      before do
        book.isbn = nil
      end
      it_behaves_like 'when a book is invalid'
    end
  end
end

describe Problem do
  it 'function returns true when input is a vector of Strings and Fixnums' do
    expect(Problem.algorithm([1,2,3,'4.5'])).to eq true
    expect(Problem.algorithm([2,3,'4.5','6.7'])).to eq true
    expect(Problem.algorithm([])).to eq true
  end

  it 'function returns false otherwise' do
    expect(Problem.algorithm([1,2,3,4.5])).to eq false
    expect(Problem.algorithm([2,3,4.5,6.7])).to eq false
  end
end
