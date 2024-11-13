class Api::V1::OrdersController < Api::V1::ApiController
  def index
    restaurant = Restaurant.find_by(code: params[:restaurant_code])
    if restaurant
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
      orders = restaurant.orders.where(status: status_value) if status_value && restaurant.orders.where(status: status_value).any?
      if params[:status] && status_value.nil?
        orders = restaurant.orders.where(status: params[:status]) if restaurant.orders.where(status: params[:status]).any?      
      end
      orders = restaurant.orders unless orders 

      order_list = []
      orders.each do |order|
        order_list << { Codigo: order.code, Status: Order.human_enum_name(:status, order.status)}
      end
      render status: 200, json: order_list
    else
      render json: { error: 'Restaurante não encontrado' }, status: 404
    end
  end
end