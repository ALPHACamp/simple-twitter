class UsersController < ApplicationController
  before_action :set_user ,only: [:tweets, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.order('created_at desc').page(params[:page]).per(10)
  end

  def edit
  end

  def update
  end

  def followings
    # @followings # 基於測試規格，必須講定變數名稱
    @followings = @user.followings
  end

  def followers
    # @followers # 基於測試規格，必須講定變數名稱
    @followers = @user.followers
  end

  def likes
    # @likes # 基於測試規格，必須講定變數名稱
    @likes = @user.liked_tweets
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
