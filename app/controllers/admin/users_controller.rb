class Admin::UsersController < Admin::BaseController
  def index
    @users = User.page(params[:page]).per(20)
  end
end
