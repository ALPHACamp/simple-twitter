class Admin::BaseController < ApplicationController
  before_action :authenticate_admin
  #admin才可以進後台
  private 
    def authenticate_admin
      unless current_user.admin?
        flash[:alert] = "Not allow!"
        redirect_to root_path
      end
    end
end
