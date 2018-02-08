class Admin::BaseController < ApplicationController
  before_action :is_admin


  def is_admin
    unless current_user.admin?
      redirect_to root_path
      flash[:alert] = "you are not admin!!"
    end
  end

end
