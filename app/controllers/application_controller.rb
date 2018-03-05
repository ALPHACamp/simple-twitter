class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 加入認證程序，使用者需登入才能瀏覽網站
  before_action :authenticate_user!

  # 請參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  # https://github.com/plataformatec/devise#strong-parameters
  # 注意有 sign_up 和 account_update 兩種參數要處理
  # add new permitted parameter to devise filter before add parameters to User
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Devise 客製化屬性
  def configure_permitted_parameters
    # 註冊時，多允許一個參數傳入
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # 編輯帳號時，多允許一個參數更新
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
