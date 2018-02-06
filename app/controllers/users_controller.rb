class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def followings
    @user = User.find(params[:id])
    # @followings 基於測試規格，必須講定變數名稱
    @followings = @user.followings
  end

  def followers
    @followships = Followship.where(following_id: params[:id])
    # @followers 基於測試規格，必須講定變數名稱
    @followers = User.where(id: @followships.select(:user_id))
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

end
