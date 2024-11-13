class Api::V1::RestaurantsController < Api::V1::ApiController
  def show
    restaurant = Restaurant.find_by(code: params[:code])
    if restaurant
      orders = restaurant.orders.map do |order|
        {
          code: order.code,
          status: I18n.t(order.status)
        }
      end
      render status: 200, json: orders
    else
      render json: { error: 'Restaurante não encontrado' }, status: 404
    end
  end
end