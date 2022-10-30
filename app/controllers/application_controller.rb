class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :success, :info, :warning, :danger

  def after_sign_in_path_for(resource)
    user_path(current_user[:id])
  end

  def create
      @user = login(params[:name], params[:password])
      if @user
        redirect_back_or_to user_path(current_user[:id])
      else
        render :new
      end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
