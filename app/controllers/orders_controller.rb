class OrdersController < ApplicationController
  before_action :authenticate_admin_or_user
  before_action :register_a_restaurant
  before_action :set_and_check_restaurant, only: [:index ,:new, :create, :show]
  
  def index
    @orders = @restaurant.orders
  end
  
  def new
    @order = Order.new
  end 

  def create    
    @order = @restaurant.orders.build(order_params)
    @cart.orderable_beverages.each do |orderable_beverage|
      @order.orderable_beverages << orderable_beverage
      orderable_beverage.cart_id = nil
    end
    @cart.orderable_dishes.each do |orderable_dish|
      @order.orderable_dishes << orderable_dish
      orderable_dish.cart_id = nil
    end
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to restaurant_order_path(@restaurant, @order)
    else
      flash.now[:alert] = 'Error ao criar o pedido'
      render :new     
    end
  end

  def show
    @order = Order.find(params[:id])
  end




  private
  def order_params
    params.require(:order).permit(:name, :telephone_number, :email, :cpf)
  end

  def authenticate_admin_or_user
    redirect_to root_path unless current_admin || current_user
  end

  def set_and_check_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    if (current_admin && @restaurant != current_admin.restaurant) || (current_user && @restaurant != current_user.restaurant)
      redirect_to root_path, alert: "Você não possui acesso a este cardápio"
    end
  end
end