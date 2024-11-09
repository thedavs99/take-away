class UsersController < ApplicationController
  before_action :set_restaurant_and_check_restaurant, only: [:new]
  def new
    @user = User.new
  end

  private
  def set_restaurant_and_check_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant != current_admin.restaurant
      redirect_to restaurant_path(current_admin.restaurant), alert: "Você não possui acesso a este restaurante"
    end
  end
end