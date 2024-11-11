class WorkersController < ApplicationController
  before_action :auth_admin
  before_action :set_restaurant_and_check_restaurant, only: [ :index, :new, :create ]

  def index
    @workers = @restaurant.workers
  end
  def new
    @worker = Worker.new
  end

  def create
    @worker = @restaurant.workers.build(worker_params)
    if @worker.save
      redirect_to restaurant_workers_path(@restaurant), notice: 'Trabalhador cadastrado com sucesso'
    else
      flash.now[:alert] = 'Trabalhador não cadastrado'
      render 'new', status: :unprocessable_entity
    end
  end

  private
  def set_restaurant_and_check_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant != current_admin.restaurant
      redirect_to restaurant_path(current_admin.restaurant), alert: "Você não possui acesso a este restaurante"
    end
  end

  def worker_params
    params.require(:worker).permit(:email, :cpf)
  end
end