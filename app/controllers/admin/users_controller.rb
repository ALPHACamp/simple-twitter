class Admin::UsersController < Admin::BaseController
  def index
    @users = User.joins(:tweets).group("tweets.user_id").select("DISTINCT ON (unique_col) *").order("count(tweets.user_id) desc")
    
  end
end
