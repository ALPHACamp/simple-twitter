class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(tweets_count: :desc)
  end

  def destroy
    @users = User.find(params[:id])
    @users.destroy
    redirect_to admin_users_path
    flash[:alert] = "User was delete"
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end
  
end
