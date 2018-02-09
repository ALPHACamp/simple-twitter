class Admin::UsersController < Admin::BaseController
  
  def index
    
    @users = User.select('*').left_joins(:tweets).group(:id).order('COUNT(tweets.id) DESC')
  end
end
