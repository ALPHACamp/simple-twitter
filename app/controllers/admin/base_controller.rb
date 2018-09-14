class Admin::BaseController < ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    if current_user == nil
      flash[:alert] = "You need login!"
      redirect_to root_path
      return
    end
    unless current_user.admin?
      flash[:alert] = "Only for admin user!"
      redirect_to root_path
    end
  end
  
end
