require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :request do
  before(:example) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)

    get new_user_session_path
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }

    @recipe = Recipe.create(user: @user, name: 'Pizza', preparation_time: 2, cooking_time: 1,
                            description: 'Italian Dish', public: true)
    @food = Food.create(user: @user, name: 'Cheese', measurement_unit: 'grams', price: 5, quantity: 10)
    @recipe_food = RecipeFood.create(recipe: @recipe, food: @food, quantity: 1)
  end

  describe 'GET /new' do
    before do
      get new_recipe_recipe_food_path(@recipe)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(200)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end

    it 'contains the correct content' do
      expect(response.body).to include 'Add Ingredient'
    end
  end

  describe 'POST /create' do
    before do
      post recipe_recipe_foods_path(@recipe),
           params: { recipe_food: { recipe_id: @recipe.id, food_id: @food.id, quantity: 1 } }
    end

    it 'returns a success response' do
      expect(response).to have_http_status(200)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end
  end

  describe 'DELETE /destroy' do
    before do
      delete recipe_recipe_food_path(@recipe, @recipe_food)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:found)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end
  end
end
