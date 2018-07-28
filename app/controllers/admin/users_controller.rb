class Admin::UsersController < Admin::BaseController
  before_action :authenticate_admin
  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(10)
  end

end
