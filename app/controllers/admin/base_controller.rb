class Admin::BaseController < ApplicationController
# 後台登入先確認user登入再確認身份為admin，authenticate_admin方法要另外定義
before_action :authenticate_user!
before_action :authenticate_admin

private

def authenticate_admin
    unless current_user.admin? #admin?要另外在user model定義
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end
end
