class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(tweets_count: :desc, role: :asc).page(params[:page]).per(10)
  end
end
