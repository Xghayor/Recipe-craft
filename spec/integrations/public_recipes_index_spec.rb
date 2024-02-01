require 'rails_helper'

RSpec.describe 'Public Recipes', type: :feature do
  before :each do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)

    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    @recipe = Recipe.create(user: @user, name: 'Pizza', preparation_time: 2, cooking_time: 1,
                            description: 'Italian Dish', public: true)

    click_button 'Log out'

    visit public_recipes_path
  end

  it 'Displays the heading' do
    expect(page).to have_content('Public Recipes')
  end

  it 'Displays the Recipe Name' do
    expect(page).to have_content('Pizza')
  end

  it 'Displays the Total Products' do
    expect(page).to have_content('Total')
  end

  it 'Displays the navbar content' do
    expect(page).to have_content('Home')
  end
end
