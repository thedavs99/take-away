class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500
  rescue_from ActiveRecord::RecordNotFound, with: :return_400
  
  private

  def return_500
    render json: { error: 'Erro do servidor' }, status: 500
  end

  def return_400
    render status: 400
  end
end