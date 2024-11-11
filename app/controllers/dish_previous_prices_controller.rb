class DishPreviousPricesController < ApplicationController
  before_action :auth_admin
  before_action :register_a_restaurant
  def create
    @dish = Dish.find(params[:dish_id])
    @dish_portion = DishPortion.find(params[:dish_portion_id])
    @last_price = @dish_portion.dish_previous_prices.last
    @last_price.update(end_date: Date.today)
      
    if @dish_portion.dish_previous_prices.create(price: params[:price], start_date: Date.today)
      @actual_price = @dish_portion.dish_previous_prices.last
      @dish_portion.update(price: @actual_price.price)
      redirect_to dish_path(@dish.id)
    end
  end
end