class MenusController < ApplicationController
  before_action :authenticate_admin_or_user
  before_action :register_a_restaurant
  before_action :set_and_check_restaurant, only: [:new, :create, :show]
  def new
    @menu = Menu.new
  end 

  def create    
    @menu = @restaurant.menus.build(menu_params)
    if @menu.save
      redirect_to root_path, notice: 'Cardápio de Restaurante cadastrado'
    else
      flash.now[:alert] = 'Não foi possivel realizar o cadastro'
      render 'new', status: :unprocessable_entity
    end  
  end

  def show
    @menu = Menu.find(params[:id])
  end




  private
  def menu_params
    params.require(:menu).permit(:name, dish_ids: [], beverage_ids: [])
  end

  def authenticate_admin_or_user
    redirect_to root_path unless current_admin || current_user
  end

  def set_and_check_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    if (current_admin && @restaurant != current_admin.restaurant) || (current_user && @restaurant != current_user.restaurant)
      redirect_to root_path, alert: "Você não possui acesso a este cardápio"
    end
  end
end