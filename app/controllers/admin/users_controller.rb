class Admin::UsersController < Admin::BaseController

  def index
    
    @users = User.page(params[:page]).per(9)

  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end
  
end
