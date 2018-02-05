class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user! # 登入才能使用網站

  # 請參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  # https://github.com/plataformatec/devise#strong-parameters
  # 注意有 sign_up 和 account_update 兩種參數要處理

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow"
      redirect_to root_path
    end  
  end
end
