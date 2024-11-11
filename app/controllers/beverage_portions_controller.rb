class BeveragePortionsController < ApplicationController
  before_action :auth_admin
  before_action :register_a_restaurant  
  before_action :set_beverage_portion_and_check_restaurant, only: [ :new, :create, :show]
  def new
    @beverage_portion = BeveragePortion.new
  end

  def create
    @beverage = Beverage.find(params[:beverage_id])
    beverage_portion_params = params.require(:beverage_portion).permit(:description, :price)
    @beverage.beverage_portions.build(beverage_portion_params)
    if @beverage.save
      redirect_to @beverage
    end
  end

  def show
    @beverage_portion = BeveragePortion.find(params[:id])
  end

  private
  def set_beverage_portion_and_check_restaurant
    @beverage = Beverage.find(params[:beverage_id])
    if @beverage.restaurant != current_admin.restaurant
      redirect_to root_path, alert: "Você não possui acesso a este prato"
    end
  end

end