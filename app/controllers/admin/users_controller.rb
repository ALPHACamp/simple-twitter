class Admin::UsersController < Admin::BaseController
  def index
    @user = User.joins(:tweets).group("tweets.user_id").order("count(tweets.user_id) desc")

  end
end
