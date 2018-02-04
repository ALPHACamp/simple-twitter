class UsersController < ApplicationController

  def tweets
    @tweets = Tweet.all
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.save
    redirect_to tweets_user_path(@user)
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.like_tweets  # 基於測試規格，必須講定變數名稱
  end

  private
  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end


end
