class HomeController < ApplicationController
  before_action :register_a_restaurant
  def index
    if current_admin
      @restaurant = current_admin.restaurant
      @menus = @restaurant.menus
    end
  end
end