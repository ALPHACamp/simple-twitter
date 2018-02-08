class UsersController < ApplicationController

  #個別user的推播與簡介
  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def edit
  end

  def update
  end

  def followings
    # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

end
