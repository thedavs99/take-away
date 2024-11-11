class RestaurantSchedulesController < ApplicationController
  before_action :auth_admin
  before_action :register_a_restaurant, only: [:show]
  before_action :check_user_restaurant_have_an_schedule, only: [:new, :create]
  before_action :set_restaurant_schedule_and_check_restaurant, only: [ :show, :edit, :update ]
  def new
    @restaurant_schedule = RestaurantSchedule.new
  end
  
  def create
    @restaurant_schedule = RestaurantSchedule.new(restaurant_schedule_params)
    @restaurant_schedule.restaurant = current_admin.restaurant
    if @restaurant_schedule.save
    redirect_to restaurant_path(current_admin.restaurant), notice: 'Horário de Restaurante cadastrado'
    else
      @restaurant_schedule.restaurant = nil
      flash.now[:alert] = 'Horário de Restaurante não cadastrado'
      render 'new', status: :unprocessable_entity
    end  
  end

  def show; end

  def edit; end

  def update
    if @restaurant_schedule.update(restaurant_schedule_params)
      redirect_to restaurant_path(current_admin.restaurant), notice: 'Horário de Restaurante editado'
    else
      flash.now[:alert] = 'Horário de Restaurante não editado'
      render 'edit', status: :unprocessable_entity
    end      
  end

  private 
  def check_user_restaurant_have_an_schedule
    unless current_admin.restaurant.restaurant_schedule.nil?
      return redirect_to restaurant_path(current_admin.restaurant) unless current_admin.restaurant.restaurant_schedule.nil?
    end
  end

  def set_restaurant_schedule_and_check_restaurant
    @restaurant_schedule = RestaurantSchedule.find(params[:id])
    if @restaurant_schedule.restaurant != current_admin.restaurant
      redirect_to restaurant_schedule_path(current_admin.restaurant.restaurant_schedule), alert: "Você não possui acesso a este restaurante"
    end
  end

  def restaurant_schedule_params
    params.require(:restaurant_schedule).permit(:mon_open, :mon_close, :tue_close,
                                                :tue_open, :wed_close, :wed_open, :thu_open, :thu_close, :fri_close, 
                                                :fri_open, :sat_open, :sat_close, :sun_close, :sun_open)
  end
end