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
    @title = "Followings"
    @user = User.find(params[:id])
    @follows = @user.followings.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
    render 'show_follow'  
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @follows = @user.followers.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
    render 'show_follow'
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

end
