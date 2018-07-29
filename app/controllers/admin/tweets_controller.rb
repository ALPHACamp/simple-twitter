class Admin::TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    
  end

  private

    def authenticate_admin
      unless current_user.admin?
        flash[:alert] = "非工作人員請勿進入!"
        redirect_to root_path
    end
  end
end
