class DishPortionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :register_a_restaurant
  before_action :set_dish_portion_and_check_restaurant, only: [ :new, :create, :show]
  def new
    @dish_portion = DishPortion.new
  end

  def create

    dish_portion_params = params.require(:dish_portion).permit(:description, :price)
    @dish_portion = @dish.dish_portions.build(dish_portion_params)
    if @dish.save
      redirect_to @dish
    end
  end

  def show

    @dish_portion = DishPortion.find(params[:id])
  end

  private
  def set_dish_portion_and_check_restaurant
    @dish = Dish.find(params[:dish_id])
    if @dish.restaurant != current_admin.restaurant
      redirect_to root_path, alert: "Você não possui acesso a este prato"
    end
  end
end