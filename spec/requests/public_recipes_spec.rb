require 'rails_helper'

RSpec.describe 'PublicRecipes', type: :request do
  describe 'GET /public_recipes' do
    it 'Returns a success response' do
      get public_recipes_path
      expect(response).to have_http_status(200)
    end

    it 'Should render the index template' do
      get public_recipes_path
      expect(response).to render_template(:index)
    end
  end
end
