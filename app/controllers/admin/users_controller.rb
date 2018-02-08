class Admin::UsersController < Admin::BaseController
  def index
    @users = User.select("users.*, count(tweets.user_id) as tweets_count").left_joins(:tweets).group("users.id").order("tweets_count DESC")
  end
end
