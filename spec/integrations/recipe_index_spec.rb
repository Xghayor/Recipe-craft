require 'rails_helper'

RSpec.describe 'Recipe List Page', type: :feature do
  before do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)

    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    Recipe.create(name: 'Pizza', description: 'Delicious', user_id: @user.id)
    Recipe.create(name: 'Burger', description: 'Delicious', user_id: @user.id)

    visit recipes_path
  end

  scenario 'Display the header: Recipe List Page' do
    expect(page).to have_content('Recipe List Page')
  end

  scenario 'Display a link to create a new recipe' do
    expect(page).to have_link('New Recipe', href: new_recipe_path)
  end

  scenario 'redirect to the new recipe page when clicking on the New Recipe link' do
    click_link('New Recipe')
    expect(page).to have_current_path(new_recipe_path)
  end

  scenario 'Display a link to view the details of the recipe' do
    expect(page).to have_link('Pizza', href: recipe_path(Recipe.find_by(name: 'Pizza')))
    expect(page).to have_link('Burger', href: recipe_path(Recipe.find_by(name: 'Burger')))
  end

  scenario 'redirect to the recipe details page when clicking on the recipe name' do
    click_link('Pizza')
    expect(page).to have_current_path(recipe_path(Recipe.find_by(name: 'Pizza')))
  end

  scenario 'Display short information about recipe' do
    expect(page).to have_content('Delicious')
  end

  scenario 'Display a delete button to delete a recipe' do
    expect(page).to have_button('Delete Recipe')
  end
end
