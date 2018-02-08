class Admin::UsersController < Admin::BaseController
  
  def index
    #@users2 = User.order(likes_count: :desc)
    @users = User.all.left_joins(:tweets).group(:id).order('COUNT(tweets.id) ASC')
  end
end
