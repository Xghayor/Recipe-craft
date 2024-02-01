require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  before do
    @user = User.create(name: 'Test User', email: 'test@gmail.com', password: 'password', confirmed_at: Time.now)
    sign_in @user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to have_http_status(200)
    end

    it 'assigns user and foods' do
      get :index, params: {}
      expect(assigns(:user)).to eq(@user)
      expect(assigns(:foods)).to eq(@user.foods)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the food' do
      food = @user.foods.create(name: 'Test Food', measurement_unit: 'grams', price: 10, quantity: 1)
      delete :destroy, params: { id: food.id }
      expect(Food.find_by(id: food.id)).to be_nil
    end

    it 'deleted food should not be in foods list' do
      food = @user.foods.create(name: 'Test Food', measurement_unit: 'grams', price: 10, quantity: 1)
      delete :destroy, params: { id: food.id }
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: {}
      expect(response).to render_template(:new)
    end

    it 'assigns a new food object' do
      get :new, params: {}
      expect(assigns(:food)).to be_a_new(Food)
    end
  end

  describe 'POST #create' do
    context 'with invalid parameters' do
      it 'does not create a new food' do
        food_params = { name: 'New Food', measurement_unit: 'pieces', price: 5, quantity: nil }
        expect do
          post :create, params: { food: food_params }
        end.to change(Food, :count).by(0)
        expect(response).to render_template(:new)
        expect(flash[:error]).to be_present
      end
    end

    context 'with valid parameters' do
      it 'creates a new food' do
        food_params = { name: 'New Food', measurement_unit: 'pieces', price: 5, quantity: 2 }
        expect do
          post :create, params: { food: food_params }
        end.to change(Food, :count).by(1)
        expect(response).to redirect_to(foods_path)
        expect(flash[:success]).to be_present
      end
    end
  end
end
