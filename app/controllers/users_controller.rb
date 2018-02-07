class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: params[:id])
  end

  def edit
  end

  def update
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = Like.where(user_id: params[:id]) # 基於測試規格，必須講定變數名稱
  end

end
