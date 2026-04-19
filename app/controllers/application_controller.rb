class ApplicationController < ActionController::Base
  helper_method :current_cart
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    products_path
  end

  def current_cart 
    if current_user
      current_user.carts.find_or_create_by(user: current_user)
    else
      Cart.find_or_create_by(session_id: session.id.to_s)   
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
