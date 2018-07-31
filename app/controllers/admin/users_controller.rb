class Admin::UsersController < ApplicationController
  before_action :authenticate_admin
  
  def index
    @users = User.page(params[:page]).per(10)
  end
  
end
