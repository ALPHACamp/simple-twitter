class Admin::UsersController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @users = User.all.order(tweets_count: :desc).page(params[:page]).per(15)
  end

  private
  def authenticate_admin
    unless current_user.role == 'admin'
      redirect_back(fallback_location: root_path, alert: "You are Not admin !")
    end
  end
end
