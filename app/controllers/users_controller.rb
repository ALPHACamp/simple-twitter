class UsersController < ApplicationController

  before_action :set_user, only: [:tweets, :edit, :update, :likes]

  def tweets
    @tweets = @user.tweets # 跟 replies/index.html.erb 的 Tweet.count 有關
    @likes = @user.likes # like 的計數
  end

  def edit
  end

  def update
    @user.update(user_params)
    @user.save
    redirect_to tweets_user_path
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets  # 基於測試規格，必須講定變數名稱
    @tweets = @user.tweets # 跟 replies/index.html.erb 的 Tweet.count 有關
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end  

end
