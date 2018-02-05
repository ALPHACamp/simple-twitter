class Admin::BaseController < ApplicationController
  before_action :authenticate_admin

  private

    # 是否為Admin
    def authenticate_admin
      # unless 是回傳false時 執行以下method
      # 是否為Admin, 否：執行方法, 是：不執行方法
      unless current_user.admin?
        flash[:alert] = "Not allow!"
        redirect_to root_path
      end
    end 
end
