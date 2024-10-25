class RestaurantsController < ApplicationController
  before_action :authenticate_admin!
  before_action :register_a_restaurant, only: [:show]
  before_action :check_user_own_a_restaurant, only: [:new, :create]
  before_action :set_restaurant_and_check_restaurant, only: [:show, :edit, :update]
  def new
    @restaurant = Restaurant.new
  end

  def create
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
    if DateTime.now.wday == 1 && DateTime.now.strftime("%H:%M") < @restaurant.restaurant_schedule.mon_close.strftime("%H:%M") && DateTime.now.strftime("%H:%M") > @restaurant.restaurant_schedule.mon_open.strftime("%H:%M")
      @status = 'Aberto'
    elsif DateTime.now.wday == 2 && DateTime.now.strftime("%H:%M") < @restaurant.restaurant_schedule.tue_close.strftime("%H:%M") && DateTime.now.strftime("%H:%M") > @restaurant.restaurant_schedule.tue_open.strftime("%H:%M")
      @status = 'Aberto' 
    elsif DateTime.now.wday == 3 && DateTime.now.strftime("%H:%M") < @restaurant.restaurant_schedule.wed_close.strftime("%H:%M") && DateTime.now.strftime("%H:%M") > @restaurant.restaurant_schedule.wed_open.strftime("%H:%M")
      @status = 'Aberto' 
    elsif DateTime.now.wday == 4 && DateTime.now.strftime("%H:%M") < @restaurant.restaurant_schedule.thu_close.strftime("%H:%M") && DateTime.now.strftime("%H:%M") > @restaurant.restaurant_schedule.thu_open.strftime("%H:%M")
      @status = 'Aberto' 
    elsif DateTime.now.wday == 5 && DateTime.now.strftime("%H:%M") < @restaurant.restaurant_schedule.fri_close.strftime("%H:%M") && DateTime.now.strftime("%H:%M") > @restaurant.restaurant_schedule.fri_open.strftime("%H:%M")
      @status = 'Aberto' 
    elsif DateTime.now.wday == 6 && DateTime.now.strftime("%H:%M") < @restaurant.restaurant_schedule.sab_close.strftime("%H:%M") && DateTime.now.strftime("%H:%M") > @restaurant.restaurant_schedule.sab_open.strftime("%H:%M")
      @status = 'Aberto' 
    elsif DateTime.now.wday == 7 && DateTime.now.strftime("%H:%M") < @restaurant.restaurant_schedule.sun_close.strftime("%H:%M") && DateTime.now.strftime("%H:%M") > @restaurant.restaurant_schedule.sun_open.strftime("%H:%M")
      @status = 'Aberto' 
    else
      @status = 'Fechado'
    end
  end

  def edit; end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(current_admin.restaurant), notice: 'Horário de Restaurante editado'
    else
      flash.now[:alert] = 'Horário de Restaurante não editado'
      render 'new', status: :unprocessable_entity
    end      
  end


  
  private 
  def check_user_own_a_restaurant
    unless current_admin.restaurant.nil?
      return redirect_to restaurant_path(current_admin.restaurant) unless current_admin.restaurant.restaurant_schedule.nil?
      redirect_to restaurant_path(new_restaurant_schedule_path)
    end
  end

  def set_restaurant_and_check_restaurant
    @restaurant = Restaurant.find(params[:id])
    if @restaurant != current_admin.restaurant
      redirect_to restaurant_path(current_admin.restaurant), alert: "Você não possui acesso a este restaurante"
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:corporate_name, :brand_name, :cnpj,
                        :email, :telephone_number, :full_address  )
  end
end

