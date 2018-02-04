class UsersController < ApplicationController
  before_action :set_user, only: [:tweets,:followings,:followers,:edit]
  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def edit
    
  end

  def update
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(created_at: :desc)# 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
