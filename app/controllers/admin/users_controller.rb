class Admin::UsersController < Admin::BaseController
	before_action :authenticate_user!
  	before_action :authenticate_admin

  def index
  	@users = User.left_joins(:tweets).group(:id).order('COUNT(tweets.id) DESC')
  end
end
