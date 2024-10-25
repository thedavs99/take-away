class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf, :restaurant_owner])
  end

  def register_a_restaurant 
    unless current_admin.nil?      
      return redirect_to new_restaurant_path if current_admin.restaurant.nil?    
      redirect_to new_restaurant_schedule_path if current_admin.restaurant.restaurant_schedule.nil?
    end      
  end


end
