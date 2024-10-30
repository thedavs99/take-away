class DishPortionsController < ApplicationController
  def new
    @dish = Dish.find(params[:dish_id])
    @dish_portion = DishPortion.new
  end

  def create
    @dish = Dish.find(params[:dish_id])
    dish_portion_params = params.require(:dish_portion).permit(:description, :price)
    @dish.dish_portions.build(dish_portion_params)
    if @dish.save
      redirect_to @dish
    end
  end
end