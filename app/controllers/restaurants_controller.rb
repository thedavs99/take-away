class RestaurantsController < ApplicationController
  before_action :register_a_restaurant, only: [:show]
  def new
    @restaurant = Restaurant.new
  end

  def create
    restaurant_params = params.require(:restaurant).permit(:corporate_name, :brand_name, :cnpj,
                              :email, :telephone_number, :full_address  )
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.admin_id = current_admin.id
    @restaurant.save
    redirect_to @restaurant, notice: 'Restaurante cadastrado'
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end