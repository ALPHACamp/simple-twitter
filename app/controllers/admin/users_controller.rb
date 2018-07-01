class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order('users.created_at DESC')
  end
end
