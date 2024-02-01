require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }
  subject { Recipe.new(name: 'Recipe Name', description: 'Recipe Description', user_id: user.id) }

  before { subject.save }

  describe 'Validation: ' do
    it 'Recipe name is required' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Recipe description is required' do
      subject.description = nil
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
