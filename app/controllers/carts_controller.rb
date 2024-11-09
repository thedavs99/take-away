class CartsController < ApplicationController

  def add_dish
    @dish_portion = DishPortion.find_by(id: params[:id])
    
    
    quantity = params[:quantity].to_i
    current_orderable_dish = @cart.orderable_dishes.find_by(dish_portion_id: @dish_portion.id)
  
    if current_orderable_dish && quantity > 0
      if current_orderable_dish.update(quantity: quantity)
        redirect_back_or_to root_path, notice: 'Pedido adicionado ao carinho'
      else
        redirect_back_or_to root_path, notice: 'Quantidade deve ser maior a 0'
      end
    else
      @orderable_dish = @cart.orderable_dishes.build(dish_portion_id: @dish_portion.id, quantity: quantity)
      if @orderable_dish.save
        redirect_back_or_to root_path, notice: 'Pedido adicionado ao carinho'
      else
        redirect_back_or_to root_path, notice: 'Quantidade deve ser maior a 0'
      end
    end    
  end

  def remove_dish
    OrderableDish.find_by(id: params[:id]).destroy
    redirect_back_or_to root_path
  end

  def add_beverage
    @beverage_portion = BeveragePortion.find_by(id: params[:id])
    
    quantity = params[:quantity].to_i
    current_orderable_beverage = @cart.orderable_beverages.find_by(beverage_portion_id: @beverage_portion.id)
    if current_orderable_beverage && quantity > 0
      if current_orderable_dish.update(quantity: quantity)
        redirect_back_or_to root_path, notice: 'Pedido adicionado ao carinho'
      else
        redirect_back_or_to root_path, notice: 'Quantidade deve ser maior a 0'
      end
    else
      @orderable_beverage = @cart.orderable_beverages.build(beverage_portion_id: @beverage_portion.id, quantity: quantity)
      if @orderable_beverage.save
        redirect_back_or_to root_path, notice: 'Pedido adicionado ao carinho'
      else
        redirect_back_or_to root_path, notice: 'Quantidade deve ser maior a 0'
      end
    end   
  end

  def remove_beverage
    OrderableBeverage.find_by(id: params[:id]).destroy
    redirect_back_or_to root_path
  end
end