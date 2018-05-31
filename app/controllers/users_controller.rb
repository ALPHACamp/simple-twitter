class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweet = @user.tweets.all.order(created_at: :desc)
  end

  def edit
  end

  def update
  end

  def followings
    set_user
    @followings = @user.followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    set_user
    @followers = @user.followers# 基於測試規格，必須講定變數名稱
  end

  def likes
    set_user
    @likes = @user.liked_tweet# 基於測試規格，必須講定變數名稱
  end

  
  private

  def set_user
    @user = User.find(params[:id])
  end

  


end
