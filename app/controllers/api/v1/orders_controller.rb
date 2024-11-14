class Api::V1::OrdersController < Api::V1::ApiController
  before_action :set_restaurant

  def index
    case params[:status]
    when "Aguardando_confirmacao_da_cozinha" 
      status_value = 0
    when "Em_preparacao" 
      status_value = 2
    when "Cancelado" 
      status_value= 4
    when "Pronto" 
      status_value= 6 
    when "Entregue" 
      status_value= 8    
    end
    orders = @restaurant.orders.where(status: status_value) if status_value && @restaurant.orders.where(status: status_value).any?

    if params[:status] && status_value.nil?
      orders = @restaurant.orders.where(status: params[:status]) if @restaurant.orders.where(status: params[:status]).any?      
    end

    orders = @restaurant.orders unless orders 

    order_list = []
    orders.each do |order|
      order_list << { "#{Order.human_attribute_name("code")}": order.code, "#{Order.human_attribute_name("status")}": Order.human_enum_name(:status, order.status)}
    end
    render status: 200, json: order_list      
  end

  def show
    order = @restaurant.orders.find_by(code: params[:code])
    if order
      order_json = set_json_with_I18n(order)
      render status: 200, json: order_json
    else
      render json: { error: 'Pedido não encontrado' }, status: 404
    end
  end

  def in_preparation
    order = @restaurant.orders.find_by(code: params[:code])
    if order
      return render json: { error: 'Só é possivel aplicar a pedidos Aguardando confirmação da cozinha' }, status: 422 unless order.awaiting_kitchen_confirmation?
      order.in_preparation!
      order.save
      order_json = set_json_with_I18n(order)
      render status: 200, json: order_json
    else
      render json: { error: 'Pedido não encontrado' }, status: 404
    end   
  end

  def ready
    order = @restaurant.orders.find_by(code: params[:code])
    if order
      return render json: { error: 'Só é possivel aplicar a pedidos em preparação' }, status: 422 unless order.awaiting_kitchen_confirmation?
      order.ready!
      order.save
      order_json = set_json_with_I18n(order)
      render status: 200, json: order_json
    else
      render json: { error: 'Pedido não encontrado' }, status: 404
    end   
  end

  private 

  def set_restaurant 
    @restaurant = Restaurant.find_by(code: params[:restaurant_code])
    unless @restaurant
      return render json: { error: 'Restaurante não encontrado' }, status: 404
    end
  end

  def set_json_with_I18n(order)
    { 
      "#{Order.human_attribute_name("code")}": order.code,
      "#{Order.human_attribute_name("name")}": order.name,
      "#{Order.human_attribute_name("email")}": order.email,
      "#{Order.human_attribute_name("cpf")}": order.cpf, 
      "#{Order.human_attribute_name("created_at")}": order.created_at.strftime("%d/%m/%Y"), 
      "#{Order.human_attribute_name("status")}": Order.human_enum_name(:status, order.status),
      Itens: set_items(order.orderable_dishes, order.orderable_beverages),
      "#{Order.human_attribute_name("total")}": order.total
    }
  end

  def set_items(orderable_dishes, orderable_beverages)
    {
      "#{OrderableDish.model_name.human}": set_dishes(orderable_dishes),
      "#{OrderableBeverage.model_name.human}": set_beverages(orderable_beverages)
    }
  end


  def set_dishes(orderable_dishes)
    json_dishes = []
    orderable_dishes.each do |orderable_dish|
      dish_portion = orderable_dish.dish_portion
      json_dishes << {
                      "#{Dish.human_attribute_name("name")}": dish_portion.dish.name,
                      "#{DishPortion.model_name.human}": dish_portion.description,
                      "#{DishPortion.human_attribute_name("price")}": dish_portion.price,
                      "#{OrderableDish.human_attribute_name("quantity")}": orderable_dish.quantity
                     }
      end
      return json_dishes
  end

  def set_beverages(orderable_beverages)
    json_beverages = []
    orderable_beverages.each do |orderable_beverage|
      beverage_portion = orderable_beverage.beverage_portion
      json_beverages << {
                      "#{Beverage.human_attribute_name("name")}": beverage_portion.beverage.name,
                      "#{BeveragePortion.model_name.human}": beverage_portion.description,
                      "#{BeveragePortion.human_attribute_name("price")}": beverage_portion.price,
                      "#{OrderableBeverage.human_attribute_name("quantity")}": orderable_beverage.quantity
                     }
      end
      return json_beverages
  end
end