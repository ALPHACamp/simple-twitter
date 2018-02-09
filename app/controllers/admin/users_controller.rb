class Admin::UsersController < Admin::BaseController
  
  def index
    
    #@users = User.left_joins(:tweets).group(:id).order('COUNT(tweets.id) DESC')
    @users = User.select('users.*, count(tweets.id) as tweets_count').left_joins(:tweets).group(:id).order('tweets_count DESC')
  end
end
