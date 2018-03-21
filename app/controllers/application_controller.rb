class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 請參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  # https://github.com/plataformatec/devise#strong-parameters
  # 注意有 sign_up 和 account_update 兩種參數要處理

  protected
  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
     devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) }
     devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
  end

  private

  def authenticate_admin
    unless current_user.admin?    
      flash.now[:alert] = "Not allow!"
      redirect_to root_path
    end
  end
  
end
