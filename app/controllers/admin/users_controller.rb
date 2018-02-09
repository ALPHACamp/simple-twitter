class Admin::UsersController < Admin::BaseController
  
  def index
    
    @users = User.left_joins(:tweets).group(:id).order('COUNT(tweets.id) DESC')
  end
end
