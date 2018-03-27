class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :likes, :followings, :followers]
  before_action :set_followings, only: [:tweets, :likes, :followings, :followers]
  before_action :set_followers, only: [:tweets, :likes, :followings, :followers]
  before_action :set_tweets, only: [:tweets, :likes, :followings, :followers]
  before_action :set_likes, only: [:tweets, :followings, :followers]

  def tweets
  end

  def edit
  end

  def update
    @user.update(user_params)
    @user.save
    redirect_to tweets_user_path
  end

  def followings # 依追蹤時間，最新的在前
    @followings = @user.followings.order("followships.created_at DESC")
  end

  def followers # 依被追蹤時間，最新的在前
    @followers = @user.followers.order("followships.created_at DESC")
  end

  def likes # 基於測試規格，必須講定變數名稱 / 喜歡過的推播 / 依喜歡時間，最新的在前
    @likes = @user.liked_tweets.order("likes.created_at DESC")
  end

  private

  def set_user
    @user = User.find(params[:id]) # 尋找特定使用者
  end

  def set_followings
    @followings = @user.followings # 基於測試規格，必須講定變數名稱 / ollowing 的計數
  end

  def set_followers
    @followers = @user.followers # 基於測試規格，必須講定變數名稱 / 追蹤自己的人
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