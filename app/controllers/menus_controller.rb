class MenusController < ApplicationController
  before_action :authenticate_admin!
  before_action :register_a_restaurant
  before_action :set_and_check_restaurant, only: [:new, :create]
  def new
    @menu = Menu.new
  end 

  def create    
    @menu = @restaurant.menus.build(menu_params)
    if @menu.save
      redirect_to root_path, notice: 'Menu de Restaurante cadastrado'
    else
      flash.now[:alert] = 'Não foi possivel realizar o cadastro'
      render 'new', status: :unprocessable_entity
    end  
  end

  private
  def menu_params
    params.require(:menu).permit(:name, dish_ids: [], beverage_ids: [])
  end

  def set_and_check_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant != current_admin.restaurant
      redirect_to root_path, alert: "Você não possui acesso a este menu"
    end
  end
end