class Admin::UsersController < Admin::BaseController
  def index
    @users = User.left_outer_joins(:tweets).select('users.*, COUNT(tweets.id) AS tweets_count').group('users.id').page(params[:page]).per(10).order('COUNT(tweets.id) DESC')
    @count = User.all.count
  end
end
