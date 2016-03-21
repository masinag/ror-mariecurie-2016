require 'date'

describe User do
  shared_examples 'when a user is invalid' do
    it 'should return false' do
      expect(user.valid?).to eq false
    end

    it 'should have a non-empty errors array' do
      expect(user.errors.empty?).to eq false
    end
  end

  let(:user) { User.new }

  before do
    user.email = 'user@example.com'
    user.name = 'User'
    user.surname = 'Surname'
    user.sign_in_count = 12
    user.registration_date = Date.new(2011,2,4)
  end

  context "#valid?" do
    # XXX can you DRY this up?
    context "when a user is valid" do
      it 'should return true' do
        expect(user.valid?).to eq true
      end
    end
    context "when the email is empty" do
      before do
        user.email = ''
      end
      it_behaves_like 'when a user is invalid'
    end
    context "when the email is not a string" do
      before do
        user.email = 12
      end
      it_behaves_like 'when a user is invalid'
    end
    context "when the name is empty" do
      before do
        user.name = ''
      end
      it_behaves_like 'when a user is invalid'
    end
    context "when the name is not a string" do
      before do
        user.name = 12
      end
      it_behaves_like 'when a user is invalid'
    end
    context "when the surname is empty" do
      before do
        user.surname = ''
      end
      it_behaves_like 'when a user is invalid'
    end
    context "when the surname is not a string" do
      before do
        user.surname = 12
      end
      it_behaves_like 'when a user is invalid'
    end
    context "when the sign_in_count is not a fixnum" do
      before do
        user.sign_in_count = 'wut'
      end
      it_behaves_like 'when a user is invalid'
    end
    context "when the registration_date is not a date" do
      before do
        user.registration_date = 12
      end
      it_behaves_like 'when a user is invalid'
    end
  end
end

describe ProblemA do
  it 'sums all the fixnums given a vector of objects' do
    expect(ProblemA.sum_fixnums([])).to eq 0 # => 0
  end

  it 'sums all the fixnums given a vector of objects' do
    expect(ProblemA.sum_fixnums([1])).to eq 1
  end

  it 'sums all the fixnums given a vector of objects' do
    expect(ProblemA.sum_fixnums([1,2,3,'stella'])).to eq 6
  end

  it 'sums all the fixnums given a vector of objects' do
    expect(ProblemA.sum_fixnums([[1],2,3,'stella'])).to eq 5
  end
end

describe ProblemB do
  it 'retruns the maximum length given a vector of strings' do
    expect(ProblemB.max_length([])).to eq 0
  end

  it 'retruns the maximum length given a vector of strings' do
    expect(ProblemB.max_length(['a','bb','ccc'])).to eq 3
  end

  it 'retruns the maximum length given a vector of strings' do
    expect(ProblemB.max_length(['a','b'])).to eq 1
  end

  it 'retruns the maximum length given a vector of strings' do
    expect(ProblemB.max_length(['a'])).to eq 1
  end
end
