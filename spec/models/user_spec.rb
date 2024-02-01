require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe') }

  before { subject.save }

  describe 'Validation: ' do
    it 'Name is required' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Email is required' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'Email is unique' do
      user = User.new(name: 'Jane Doe', email: subject.email)
      expect(user).to_not be_valid
    end

    it 'Email is not valid' do
      subject.email = 'invalid'
      expect(subject).to_not be_valid
    end

    it 'Password is required' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'Password is too short (minimum 6 characters required)' do
      subject.password = '12345'
      expect(subject).to_not be_valid
    end

    it 'Password is too long (maximum 128 characters allowed)' do
      subject.password = 'a' * 129
      expect(subject).to_not be_valid
    end

    it 'Email is valid' do
      subject.email = 'a@gmail.com'
      subject.password = '123456'
      expect(subject).to be_valid
    end

    it 'Password is valid' do
      subject.email = 'a@gmail.com'
      subject.password = '123456'
      expect(subject).to be_valid
    end
  end

  describe 'Associations:' do
    it 'has_many recipes' do
      expect(subject).to respond_to(:recipes)
    end

    it 'has_many foods' do
      expect(subject).to respond_to(:foods)
    end
  end

  describe 'Methods:' do
    it 'admin? returns true if user is admin' do
      subject.role = 'admin'
      expect(subject.admin?).to be_truthy
    end

    it 'admin? returns false if user is not admin' do
      subject.role = 'user'
      expect(subject.admin?).to be_falsey
    end
  end
end
