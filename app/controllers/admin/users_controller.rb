class Admin::UsersController < Admin::BaseController
  before_action :authenticate_user!
  # 後台權限驗證
  before_action :authenticate_admin
  def index
    @users = User.page(params[:page]).per(10)
  end
end
