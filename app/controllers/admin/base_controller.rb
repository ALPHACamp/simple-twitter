class Admin::BaseController < ApplicationController
  before_action :authenticate_role

  private

  def authenticate_role
    redirect_to root_path if current_user.role != "admin"
  end

end
