class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # include SessionsHelper
  include ExchangesHelper
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:username]
    devise_parameter_sanitizer.for(:account_update) << [:username, :role, :stripe_recipient_id, :phone_number, :image_url, :headline] 
  end

  def after_sign_in_path_for(resource)
    exchanges = Exchange.where(user_id: current_user.id)
    last_exchange = exchanges.last 
    if exchanges.length != 0 && last_exchange.rated != "yes"
      exchange_path(last_exchange.id)
    else
      user_path(current_user.id)  
    end
    
    # binding.pry
  end

  def after_registration_path_for(resource)
    new_customer_path
  end

end
