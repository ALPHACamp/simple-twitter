class Admin::UsersController < Admin::BaseController

  def index
    @tweets = Tweet.all
    @users = User.order(tweets_count: :desc)
  end
end
