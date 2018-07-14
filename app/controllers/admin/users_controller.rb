class Admin::UsersController < Admin::BaseController
  before_action :set_user

  def index
    
    @users = User.includes(:tweets).page(params[:page]).per(9)

  end

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end 

  def show
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def set_user
    if  params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
  
end
