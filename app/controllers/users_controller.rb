class UsersController < ApplicationController
  before_action :find_user, only: [:tweets, :followings, :followers, :likes]
  def tweets
    @tweets = @user.tweets
  end

  def edit
  end

  def update
  end

  def followings
    @followings = @user.followings
    # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets
    # 基於測試規格，必須講定變數名稱
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  
end
