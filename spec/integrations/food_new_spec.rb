require 'rails_helper'

RSpec.feature 'Create a new food page', type: :feature do
  before do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)

    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    visit new_food_path(@user)
  end

  scenario 'displays Create a New Food header' do
    expect(page).to have_content('Create New Food')
  end

  scenario 'displays a form to create a new food' do
    expect(page).to have_content('Name')
    expect(page).to have_content('Price')
    expect(page).to have_content('Measurement unit')
  end

  scenario 'displays a Back to Foods link' do
    expect(page).to have_link('Back to Foods', href: foods_path)
  end

  scenario 'redirects to the food list page when the Back to Foods link is clicked' do
    click_link 'Back to Foods'

    expect(page).to have_current_path(foods_path)
  end

  scenario 'redirects to the food list page when the form is submitted' do
    fill_in 'Name', with: 'Pizza'
    fill_in 'Price', with: 10
    fill_in 'Measurement unit', with: 'Slice'
    click_button 'Create Food'

    expect(page).to have_current_path(foods_path)
  end
end
