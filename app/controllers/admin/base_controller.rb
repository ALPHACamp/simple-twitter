class Admin::BaseController < ApplicationController

  # 建立管理者認證
  before_action :authenticate_admin

  private

  # 建立管理者認證
  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

end
