class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(id: :desc)
  end
end
