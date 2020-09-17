class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name ,:icon, :profile, :artist_type])
  end
  def after_update_path_for(resource)
    user_path(id: current_user.id)
  end
end
