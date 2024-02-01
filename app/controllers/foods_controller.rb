class FoodsController < ApplicationController
  def index
    @user = current_user
    @foods = @user.foods.includes(:user)
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.quantity.present? && @food.save
      flash[:success] = 'Successfully added new food'
      redirect_to foods_path
    else
      flash[:error] = 'Error adding the food'
      render :new
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
