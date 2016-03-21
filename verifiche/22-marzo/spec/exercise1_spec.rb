require 'date'

# Esercizio 1
describe Profile do
  shared_examples 'when a profile is invalid' do |invalid_attribute|
    it 'should return false' do
      expect(profile.valid?).to eq false
    end

    it 'should have a non-empty errors array' do
      expect(profile.errors.empty?).to eq false
    end

    it "should have #{invalid_attribute} in the errors array" do
      expect(profile.errors).to include(invalid_attribute)
    end
  end

  let(:profile) do
    Profile.new
  end

  before do
    profile.name = 'User'
    profile.surname = 'Surname'
    profile.registration_date = Date.new(2011,2,4)
  end

  context "when all the fields are valid" do
    it 'should be valid' do
      expect(profile.valid?).to eq true
    end
    it 'should not have errors' do
      expect(profile.errors.any?).to eq false
    end
  end

  [:name, :surname].each do |attribute|
    context "when #{attribute} is not a string" do
      before do
        profile.send(:"#{attribute}=", 15)
      end
      it_behaves_like 'when a profile is invalid', attribute
    end
    context "when #{attribute} is empty" do
      before do
        profile.send(:"#{attribute}=", '')
      end
      it_behaves_like 'when a profile is invalid', attribute
    end
    context "when #{attribute} is 1 character long" do
      before do
        profile.send(:"#{attribute}=", 'a')
      end
      it_behaves_like 'when a profile is invalid', attribute
    end
    context "when #{attribute} is 65 characters long" do
      before do
        profile.send(:"#{attribute}=", 'a'*65)
      end
      it_behaves_like 'when a profile is invalid', attribute
    end
    context "when #{attribute} begins with a lowercase letter" do
      before do
        profile.send(:"#{attribute}=", 'abdellaram')
      end
      it_behaves_like 'when a profile is invalid', attribute
    end
    context "when #{attribute} has uppercase letters" do
      before do
        profile.send(:"#{attribute}=", 'abdellaram')
      end
      it_behaves_like 'when a profile is invalid', attribute
    end
  end

  context "when registration_date is not a Date" do
    before do
      profile.registration_date = 'pippo'
    end
    it_behaves_like 'when a profile is invalid', :registration_date
  end

end
