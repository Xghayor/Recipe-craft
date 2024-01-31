class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @recipe = Recipe.where(user: @user)
    @recipe_foods = RecipeFood.where(recipe: @recipe).group_by { |recipe_food| recipe_food.food.name }
    @total_price = @recipe_foods.map do |_food, recipe_foods|
      recipe_foods.map do |recipe_food|
        recipe_food.quantity * recipe_food.food.price.to_i
      end.sum
    end.sum
  end
end
