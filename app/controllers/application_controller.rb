class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :home_index_action?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password full_name]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[login password])
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  private

  def home_index_action?
    controller_name == 'home' && action_name == 'index'
  end
end
