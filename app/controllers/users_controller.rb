class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = Tweet.where(user: @user)
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes  =  @user.liked_tweets.order(created_at: :desc)
  end

end
