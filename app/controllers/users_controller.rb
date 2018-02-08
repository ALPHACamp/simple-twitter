class UsersController < ApplicationController

  before_action :set_user,only:[:show, :edit, :update]

  def tweets
    @tweets = Tweet.all
    
  end

  def show
    
    @user = User.find(params[:id])
    @repled_tweets = @user.tweets
    @followings = @user.followings
    @followers = @user.followers
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)      
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    # @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    # @likes # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
