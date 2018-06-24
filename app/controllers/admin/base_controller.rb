class Admin::BaseController < ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "You don't the access to the back end."
      redirect_to root_path
    end
  end
end
