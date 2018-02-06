class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def followings
    @user = User.find(params[:id])
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.liked_tweets.all.order("likes.created_at DESC") # 基於測試規格，必須講定變數名稱
    # a = @likes.first.likes.first.created_at
  end

end
