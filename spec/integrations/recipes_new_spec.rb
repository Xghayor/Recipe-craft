require 'rails_helper'

RSpec.describe 'Recipe New', type: :feature do
  before(:each) do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)

    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    visit new_recipe_path
  end

  it 'should show the title' do
    expect(page).to have_content 'Create New Recipe'
  end

  it 'should have a button to create recipe' do
    fill_in 'Name', with: 'Pizza'
    fill_in 'Preparation Time', with: '1'
    fill_in 'Cooking Time', with: '1'
    fill_in 'Description', with: 'Italian Dish'
    click_on 'Create Recipe'
  end
end
