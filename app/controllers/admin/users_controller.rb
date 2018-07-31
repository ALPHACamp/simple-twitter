class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.order(tweets_count: :desc)
  end
end
