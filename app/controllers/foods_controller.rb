class FoodsController < ApplicationController
  helper ActionView::Helpers::NumberHelper
  def index
    @user = current_user
    @foods = @user.foods
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    @user = current_user
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      flash[:success] = 'Successfully added new food'
      redirect_to foods_path
    else
      flash[:error] = 'Error adding the food'
      render :new
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
