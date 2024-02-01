require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :request do
  before(:example) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)

    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }

    @recipe = Recipe.create(user: @user, name: 'Pizza', preparation_time: 2, cooking_time: 1,
                            description: 'Italian Dish', public: true)
    @food = Food.create(user: @user, name: 'Cheese', measurement_unit: 'grams', price: 5, quantity: 10)
    @recipe_food = RecipeFood.create(recipe: @recipe, food: @food, quantity: 1)
  end

  describe 'GET /index' do
    before do
      get shopping_lists_path
    end

    it 'returns a success response' do
      expect(response).to have_http_status(200)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end

    it 'contains the correct content' do
      expect(response.body).to include 'Shopping list'
    end

    it 'contains the food name' do
      expect(response.body).to include(@food.name)
    end

    it 'contains the food price' do
      expect(response.body).to include(@food.price.to_s)
    end
  end
end
