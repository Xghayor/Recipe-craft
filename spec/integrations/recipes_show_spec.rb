require 'rails_helper'

RSpec.describe 'Recipe Details', type: :feature do
  describe 'show' do
    before(:each) do
      @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)

      visit new_user_session_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'

      @recipe = Recipe.create(user: @user, name: 'Pizza', preparation_time: 2, cooking_time: 1,
                              description: 'Italian Dish', public: true)

      visit recipe_path(@recipe.id)
    end

    it 'renders name of recipe' do
      expect(page).to have_content(@recipe.name)
    end

    it 'renders description of the recipe' do
      expect(page).to have_content(@recipe.description)
    end

    it 'renders preparation time' do
      expect(page).to have_content(@recipe.preparation_time)
    end

    it 'renders cooking time' do
      expect(page).to have_content(@recipe.cooking_time)
    end

    it 'renders add ingredient button' do
      expect(page).to have_content('Add Ingredient')
    end

    it 'redirects to add ingredient page' do
      click_link 'Add Ingredient'
      expect(page).to have_current_path(new_recipe_recipe_food_path(@recipe))
    end
  end
end
