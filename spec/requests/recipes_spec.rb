require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  before(:example) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)

    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }

    @recipe = Recipe.create(user: @user, name: 'Pizza', preparation_time: 2, cooking_time: 1,
                            description: 'Italian Dish', public: true)
  end

  describe 'GET /index' do
    before do
      get recipes_path
    end

    it 'returns a success response' do
      expect(response).to have_http_status(200)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end

    it 'contains the correct content' do
      expect(response.body).to include 'Recipe'
    end
  end

  describe 'GET /new' do
    before do
      get new_recipe_path
    end

    it 'returns a success response' do
      expect(response).to have_http_status(200)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end

    it 'contains the correct content' do
      expect(response.body).to include 'Create New Recipe'
    end
  end

  describe 'GET /show' do
    before do
      get recipe_path(@recipe)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(200)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end

    it 'contains the correct content' do
      expect(response.body).to include 'Generate Shopping List'
    end
  end
end
