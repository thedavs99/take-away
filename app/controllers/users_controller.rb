class UsersController < ApplicationController
  before_action :set_restaurant_and_check_restaurant, only: [ :index, :new, :create ]

  def index
    @users = @restaurant.users
  end
  def new
    @user = User.new
  end

  def create
    @user = @restaurant.users.build(user_params)
    if @user.save
      redirect_to restaurant_users_path(@restaurant), notice: 'Usuario cadastrado com sucesso'
    else
      flash.now[:alert] = 'Usuario não cadastrado'
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

  def user_params
    params.require(:user).permit(:email, :cpf)
  end
end