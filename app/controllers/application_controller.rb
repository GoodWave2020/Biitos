class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :show, :following, :followers, :friend_index]
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name ,:icon, :profile, :artist_type])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name ,:icon, :profile, :artist_type])
  end

  def check_user(other_user)
    if current_user != other_user
      flash[:notice] = t("you_can't_destroy_or_edit_other_user's_posting")
      redirect_to posts_path
    end
  end
end
