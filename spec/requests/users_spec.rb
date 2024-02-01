require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before do
    @user1 = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
    get users_path
  end

  describe 'GET #index' do
    it 'redirects to login page' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
