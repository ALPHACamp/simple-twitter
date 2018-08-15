class Admin::BaseController < ApplicationController
  before_action :authenticate_admin

  private

    def authenticate_admin
      unless current_user.admin?
        flash[:alert] = "非工作人員請勿進入!"
        redirect_to root_path
    end
  end

end

    
