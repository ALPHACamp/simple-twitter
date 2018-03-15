class Admin::UsersController < Admin::BaseController
  
  #顯示所有的使用者
  def index
    @users = User.all.includes(:tweets, :likes, :followships).order(tweets_count: :desc)
  end

end