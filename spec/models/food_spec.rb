require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }
  subject { Food.new(name: 'Food Name', user_id: user.id) }

  before { subject.save }

  describe 'Validation: ' do
    it 'Food name is required' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Food price is required' do
      subject.price = nil
      expect(subject).to_not be_valid
    end

    it 'Food measurement unit is required' do
      subject.measurement_unit = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations:' do
    it 'User is required' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
  end
end
