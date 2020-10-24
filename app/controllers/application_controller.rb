class ApplicationController < ActionController::Base
  include GroupsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
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
  def check_friend(conversation)
    unless current_user == @conversation.sender || current_user == @conversation.recipient
      redirect_to posts_path, notice: t("you_can't_enter_other_tokeroom")
    end
  end
  def after_sign_in_path_for(resource)
    posts_path
  end
  def after_sign_out_path_for(resource)
    top_path
  end
end
