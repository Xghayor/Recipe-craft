class PublicRecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @public_recipes = Recipe.where(public: true).includes(:user).order(created_at: :desc)
    @recipe_foods = RecipeFood.all
  end
end
