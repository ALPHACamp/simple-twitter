class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.page(params[:page]).per(10).order(created_at: :desc)            
    @count = User.all.count
  end
end
