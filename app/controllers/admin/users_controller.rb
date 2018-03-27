class Admin::UsersController < Admin::BaseController
    
  def index
    @tweets = Tweet.all
    @users = User.all.sort{|b,a| a.tweets.count <=> b.tweets.count}
  end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_root_path
    flash[:alert] = "user was delete"
  end
  
end
