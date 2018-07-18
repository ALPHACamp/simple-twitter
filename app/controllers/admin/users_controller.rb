class Admin::UsersController < Admin::BaseController
  def index
    @user = User.all.order(tweets_count: :desc)
  end
end
