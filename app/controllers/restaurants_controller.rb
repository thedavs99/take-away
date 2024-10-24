class RestaurantsController < ApplicationController
  before_action :authenticate_admin!
  before_action :register_a_restaurant, only: [:show]
  before_action :check_user_own_a_restaurant, only: [:new, :create]
  def new
    @restaurant = Restaurant.new
  end

  def create
    restaurant_params = params.require(:restaurant).permit(:corporate_name, :brand_name, :cnpj,
                              :email, :telephone_number, :full_address  )
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.admin = current_admin
    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurante cadastrado'
    else
      @restaurant.admin = nil
      flash.now[:alert] = 'Restaurante não cadastrado'
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
  
  private 
  def check_user_own_a_restaurant
    unless current_admin.restaurant == nil
      redirect_to restaurant_path(current_admin.restaurant) 
    end
  end
end