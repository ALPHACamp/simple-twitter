class UsersController < ApplicationController
  before_action :set_user
  def tweets

  end

  def edit
  end

  def update
  end

  def followings
    @followings = @user.followings.all # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers =  @user.followers.all # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.page(params[:page]).per(10) # 基於測試規格，必須講定變數名稱
  end
##############3
  private
  def set_user
    @user = User.find(params[:id])
  end

end
