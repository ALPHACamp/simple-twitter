class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  # 除了信箱和密碼，使用者在註冊時還能設定自己的名稱
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 除了註冊和登入頁，使用者一定要登入才能使用網站
  before_action :authenticate_user!
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
    devise_parameter_sanitizer.permit(:account_update, keys:[:name])
  end
  # 請參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  # https://github.com/plataformatec/devise#strong-parameters
  # 注意有 sign_up 和 account_update 兩種參數要處理
end
