class Admin::UsersController < Admin::BaseController
  
  #顯示所有的使用者
  def index
    @users = User.all
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
