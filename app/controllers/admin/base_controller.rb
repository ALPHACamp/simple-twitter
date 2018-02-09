class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  private

  def authenticate_admin
    unless current_user.admin?  #在要model/user.rb裡面加入admin?的method current_user是devise提供的helper method  但是controller如何去model裡面找到這個method
      flash[:alert] = "Not allow"
      redirect_to root_path
    end
  end 
end
