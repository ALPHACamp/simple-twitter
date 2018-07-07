class Admin::UsersController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin
  
  def index
    @users = User.all
  end

  private 
  def authenticate_admin
      unless current_user.admin?
        flash[:alert] = "Not allow!"
        redirect_to root_path
      end
  end
end
