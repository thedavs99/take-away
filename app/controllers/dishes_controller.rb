class DishesController < ApplicationController
  before_action :authenticate_admin!
  before_action :register_a_restaurant
  before_action :set_dish_and_check_restaurant, only: [:show, :edit, :update, :destroy, :inactive, :active]
  def index
    @dishes = current_admin.restaurant.dishes
  end  

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(dish_params)
    @dish.restaurant = current_admin.restaurant
    @dish.image.attach(params[:dish][:image]) 
    if @dish.save
    redirect_to dishes_path, notice: 'Prato de Restaurante cadastrado'

    else
      @dish.restaurant = nil
      flash.now[:alert] = 'Prato de Restaurante não cadastrado'
      render 'new', status: :unprocessable_entity
    end  
  end

  def show;  end

  def edit; end

  def update
    if @dish.update(dish_params)
      redirect_to dish_path(@dish), notice: 'Prato de Restaurante editado'
      if params[:dish][:image].present?
        @dish.image.attach(params[:dish][:image])         
      end        
    else
      flash.now[:alert] = 'Prato de Restaurante não editado'
        render 'edit', status: :unprocessable_entity
    end  
  end

  def destroy
    @dish.destroy
    redirect_to dishes_path, notice: "Prato removido com sucesso"
  end

  def inactive
    @dish.inactive!
    redirect_to @dish
  end

  def active
    @dish.active!
    redirect_to @dish
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :description, :calories)
  end

  def set_dish_and_check_restaurant
    @dish = Dish.find(params[:id])
    if @dish.restaurant != current_admin.restaurant
      redirect_to root_path, alert: "Você não possui acesso a este prato"
    end
  end
end