class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.includes(:tweets, :likes, :followships)
  end
end
