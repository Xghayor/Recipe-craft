require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :feature do
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

    visit new_recipe_recipe_food_path(@recipe)
  end

  it 'should show the title' do
    expect(page).to have_content 'Add Ingredient'
  end

  it 'has a select field for food' do
    expect(page).to have_select('recipe_food[food_id]')
  end
  it 'has a field for quantity' do
    expect(page).to have_field('recipe_food[quantity]')
  end

  it 'has a button to add ingredient' do
    fill_in 'recipe_food[quantity]', with: 5
    find('#recipe_food_food_id').find(:xpath, 'option[1]').select_option
    click_on 'Add'
  end
end
