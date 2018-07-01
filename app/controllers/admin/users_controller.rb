class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(created_at: :asc)
  end
end
