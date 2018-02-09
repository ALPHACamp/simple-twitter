class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order("users.created_at desc").all
    # @tweets = Tweet.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
end
