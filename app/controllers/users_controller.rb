class UsersController < ApplicationController

  before_action :set_user, only: [:tweets, :edit, :update, :likes, :followings]
  before_action :set_followings, only: [:tweets, :likes, :followings]
  before_action :set_tweets, only: [:tweets, :likes, :followings]
  before_action :set_likes, only: [:tweets, :followings]

  def tweets
  end

  def edit
  end

  def update
    @user.update(user_params)
    @user.save
    redirect_to tweets_user_path
  end

  def followings
    @followings = @user.followings # 基於測試規格，必須講定變數名稱 / 顯示關注的使用者清單
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets  # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id]) # 尋找特定使用者
  end

  def set_followings
    @followings = @user.followings # following 的計數
  end

  def set_tweets
    @tweets = @user.tweets # 跟 replies/index.html.erb 的 Tweet.count 有關
  end

  def set_likes
    @likes = @user.likes # like 的計數
  end  

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end  

end