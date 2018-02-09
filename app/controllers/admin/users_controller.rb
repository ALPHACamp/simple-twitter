class Admin::UsersController < Admin::BaseController
  def index
    @users=User.all
    @user=current_user
  end
end
