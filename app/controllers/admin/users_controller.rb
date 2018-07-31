class Admin::UsersController < Admin::BaseController
  def index
    @users =  User.order("tweets_count desc")
  end
end
