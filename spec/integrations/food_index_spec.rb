require 'rails_helper'

RSpec.feature 'Food List Page', type: :feature do
  before do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)

    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    Food.create(name: 'Pizza', price: 10, measurement_unit: 'Slice', user_id: @user.id)
    Food.create(name: 'Salad', price: 8, measurement_unit: 'Bowl', user_id: @user.id)

    visit foods_path
  end

  scenario 'displays New Food link for the current user' do
    expect(page).to have_content('New Food')
  end

  scenario 'redirects to the new food page when New Food link is clicked' do
    click_link 'New Food'
    expect(page).to have_content('Create New Food')
    expect(page).to have_current_path(new_food_path(@user))
  end

  scenario 'displays food details for each item' do
    expect(page).to have_content('Pizza')
    expect(page).to have_content('$10')
    expect(page).to have_content('Slice')

    expect(page).to have_content('Salad')
    expect(page).to have_content('$8')
    expect(page).to have_content('Bowl')
  end

  scenario 'Display Delete button for authorized user' do
    expect(page).to have_button('Delete')
  end
end
