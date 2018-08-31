class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(followers_count: :desc)
  end
end
