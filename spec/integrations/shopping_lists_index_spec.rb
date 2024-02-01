require 'rails_helper'

RSpec.describe 'Shoping Lists', type: :feature do
  before(:each) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)

    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    @recipe = Recipe.create(user: @user, name: 'Pizza', preparation_time: 2, cooking_time: 1,
                            description: 'Italian Dish', public: true)
    @food = Food.create(user: @user, name: 'Cheese', measurement_unit: 'grams', price: 5, quantity: 10)
    @recipe_food = RecipeFood.create(recipe: @recipe, food: @food, quantity: 2)

    visit shopping_lists_path
  end

  it 'should show the title' do
    expect(page).to have_content('Shopping list')
  end

  it 'should show the table headers' do
    expect(page).to have_content('Food')
    expect(page).to have_content('Quantity')
    expect(page).to have_content('Total Price')
  end

  it 'should show the food name' do
    expect(page).to have_content(@food.name)
  end

  it 'should show food items to buy' do
    expect(page).to have_content('Amount of food items to buy: 1')
  end

  it 'should show total value of food needed' do
    expect(page).to have_content('Total value of food needed: $10')
  end

  it 'should show the price column' do
    price = @food.price.to_i * @recipe_food.quantity
    expect(page).to have_content("$#{price}")
  end

  it 'should show the quantity column' do
    expect(page).to have_content(@recipe_food.quantity.to_s)
  end
end
