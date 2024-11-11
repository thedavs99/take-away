class BeveragePreviousPricesController < ApplicationController
  before_action :auth_admin
  before_action :register_a_restaurant
  def create
    @beverage = Beverage.find(params[:beverage_id])
    @beverage_portion = BeveragePortion.find(params[:beverage_portion_id])
    @last_price = @beverage_portion.beverage_previous_prices.last
    @last_price.update(end_date: Date.today)
    
    if @beverage_portion.beverage_previous_prices.create(price: params[:price], start_date: Date.today)
      @actual_price = @beverage_portion.beverage_previous_prices.last
      @beverage_portion.update(price: @actual_price.price)
      redirect_to beverage_path(@beverage.id)
    end
  end
end