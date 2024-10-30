class BeveragePortionsController < ApplicationController
  def new
    @beverage = Beverage.find(params[:beverage_id])
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
end