class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order_tweets
  end
end
