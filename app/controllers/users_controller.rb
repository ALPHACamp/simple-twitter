class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.all.order(created_at: :desc)

  end

  def edit
    @user =User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to tweets_user_path(@user)
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.all # 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.all # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.likes # 基於測試規格，必須講定變數名稱
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
