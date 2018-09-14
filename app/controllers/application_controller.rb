class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  # 請參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  # https://github.com/plataformatec/devise#strong-parameters
  # 注意有 sign_up 和 account_update 兩種參數要處理
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected #在同一個類別內或是同一個package，或是繼承它的子類別可以自由取用，但如果不是的話則不可存取

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
    end

  private #只有在類別內部可以存取

    def authenticate_admin
      unless current_user.admin?
        flash[:alert] = "You're not administrator!"
        redirect_to root_path
      end
    end

end
