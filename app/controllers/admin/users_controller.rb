class Admin::UsersController < Admin::BaseController
  
  #顯示所有的使用者
  def index
    @users = User.order(tweets_count: :desc)
    #@tweets = Tweet.find(params[:id])
    #@likes = Tweet.where(:user_id => @tweets.user).pluck(:likes_count).sum
  end

end
