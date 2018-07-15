class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(tweets_count: :desc).page(params[:page]).per(10)
  end
end
