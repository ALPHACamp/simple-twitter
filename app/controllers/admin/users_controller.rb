class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
    #@users = User.all.order(tweets_count: :desc)
  end
end
