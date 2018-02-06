class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
    @tweets = Tweet.all
  end
end
