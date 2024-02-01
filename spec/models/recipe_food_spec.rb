require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:example) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)
    @recipe = Recipe.create(user: @user, name: 'Pizza', preparation_time: 2, cooking_time: 1,
                            description: 'Italian Dish', public: true)
    @food = Food.create(user: @user, name: 'Cheese', measurement_unit: 'grams', price: 5, quantity: 10)
    @recipe_food = RecipeFood.create(recipe: @recipe, food: @food, quantity: 2)
  end

  it 'is valid with valid attributes' do
    expect(@recipe).to be_valid
  end

  it 'is not valid without name' do
    @recipe_food.quantity = 0
    expect(@recipe_food).to_not be_valid
  end

  it 'should have the correct food' do
    expect(@recipe_food.food).to be @food
  end

  it 'should have the correct recipe' do
    expect(@recipe_food.recipe).to be @recipe
  end

  it 'should have the correct quantity' do
    expect(@recipe_food.quantity).to eq(2)
  end
end
