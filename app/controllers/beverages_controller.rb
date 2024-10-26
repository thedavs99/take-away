class BeveragesController < ApplicationController
  before_action :authenticate_admin!
  before_action :register_a_restaurant
  before_action :set_beverage_and_check_restaurant, only: [ :show , :edit ,:update, :destroy ]

  def index
    @beverages = current_admin.restaurant.beverages
  end

  def new
    @beverage = Beverage.new
  end

  def create
    @beverage = Beverage.new(beverage_params)
    @beverage.restaurant = current_admin.restaurant
    @beverage.image.attach(params[:beverage][:image]) 
    if @beverage.save
    redirect_to beverages_path, notice: 'Bebida de Restaurante cadastrado'

    else
      @beverage.restaurant = nil
      flash.now[:alert] = 'BEbida de Restaurante não cadastrado'
      render 'new', status: :unprocessable_entity
    end  
  end

  def show;  end

  def edit; end

  def update
    if @beverage.update(beverage_params)
      redirect_to beverage_path(@beverage), notice: 'Bebida de Restaurante editado'
      if params[:beverage][:image].present?
        @beverage.image.attach(params[:beverage][:image])         
      end        
    else
      flash.now[:alert] = 'Bebida de Restaurante não editado'
        render 'edit', status: :unprocessable_entity
    end  
  end

  def destroy
    @beverage.destroy
    redirect_to dishes_path, notice: "Bebida removido com sucesso"
  end

  private
  def beverage_params
    params.require(:beverage).permit(:name, :description, :calories)
  end

  def set_beverage_and_check_restaurant
    @beverage = Beverage.find(params[:id])
    if @beverage.restaurant != current_admin.restaurant
      redirect_to root_path, alert: "Você não possui acesso a este bebida"
    end
  end
end