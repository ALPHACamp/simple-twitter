class ApplicationController < ActionController::Base
  
  before_action :authenticate_user!
  
  protect_from_forgery with: :exception
  
  
  # 請參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  # https://github.com/plataformatec/devise#strong-parameters
  # 注意有 sign_up 和 account_update 兩種參數要處理
  before_action :sign_up_permitted_parameters, if: :devise_controller?
  before_action :account_update_permitted_parameters, if: :devise_controller?

  protected

  def sign_up_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  def account_update_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end 
  
  private
  
  def authenticate_admin
    unless current_user.admin?
      # FIXME: flash[:alert] = "不允許登入!"
      redirect_to root_path
    end
  end
  
end
