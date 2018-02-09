class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(:role)
  end
end
