class Admin::UsersController < Admin::BaseController

  def index
    @users = User.page(params[:page]).per(10)
  end
end
