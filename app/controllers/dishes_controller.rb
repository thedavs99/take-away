class DishesController < ApplicationController
  before_action :authenticate_admin!
  before_action :register_a_restaurant
  def index
    @dishes = current_admin.restaurant.dishes
  end  

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(dish_params)
    @dish.restaurant = current_admin.restaurant
    if @dish.save
    redirect_to dishes_path, notice: 'Prato de Restaurante cadastrado'
    else
      @dish.restaurant = nil
      flash.now[:alert] = 'Prato de Restaurante não cadastrado'
      render 'new', status: :unprocessable_entity
    end  
  end

  private

  def dish_params
    params.require(:dish).permit(:nome, :description, :calories)
  end

  def set_dish_and_check_restaurant
    @dish = Dish.find(params[:id])
    if @dish.restaurant != current_admin.restaurant
      redirect_to root_path, alert: "Você não possui acesso a este prato"
    end
  end
end