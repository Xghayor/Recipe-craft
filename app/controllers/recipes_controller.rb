class RecipesController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes
  end

  def show; end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    @user = current_user
  end
end
