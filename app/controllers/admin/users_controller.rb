class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.includes(:tweets, :likes, :followships).order("tweets_count desc")
  end
end
