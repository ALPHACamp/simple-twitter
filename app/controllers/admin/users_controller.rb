class Admin::UsersController < Admin::BaseController
  def index
    @tweet = Tweet.
    @users = User.all.order(created_at: :desc)
  end
end
