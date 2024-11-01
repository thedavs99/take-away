class TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :register_a_restaurant
  before_action :set_tag_and_check_restaurant, only: [ :new, :create ]

  def new 
    @tag = Tag.new    
  end

  def create    
    tag_params = params.require(:tag).permit(:description)
    if @restaurant.tags.create(tag_params)
      redirect_back_or_to root_path
    end
  end

  private
  def set_tag_and_check_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant != current_admin.restaurant
      redirect_to root_path, alert: "Você não possui acesso a este prato"
    end
  end
end