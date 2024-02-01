class FoodsController < ApplicationController
  def index
    @user = current_user
    @foods = @user.foods.includes(:user)
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:notice] = 'Food deleted successfully'
    redirect_back(fallback_location: root_path)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user

    if @food.save
      redirect_to foods_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
