class Admin::UsersController < Admin::BaseController
  def index

    @users = User.left_outer_joins(:tweets).group(:id).order('COUNT(tweets.id) DESC')
    
  end
end
