class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit,:followings, :followers, :likes] 

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
  end

  def update
  end

  def followings
    @title = "Followings"
    @follows = @user.followings.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
    render 'show_follow'  
  end

  def followers
    @title = "Followers"
    @follows = @user.followers.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
    render 'show_follow'
  end

  def likes
    @title = "Likes"
    @likes = @user.like_tweets.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
    render 'show_like'  
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


end
