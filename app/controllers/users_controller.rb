class UsersController < ApplicationController
  before_action :set_user

  def tweets
    @tweets = @user.tweets
  end

  def edit
    #併入devise頁面
  end

  def update
    #併入devise頁面
  end

  def followings
    @followings = @user.followings.order('followships.created_at DESC')
    # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order('followships.created_at DESC') 
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.like_tweets # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
