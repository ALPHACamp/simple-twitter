class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :tweets, :followings, :followers, :likes]
  def tweets
    @tweets = @user.tweets.order("created_at DESC")
  end

  def edit
    if @user == current_user
      render :edit
    else
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_profile_params)
      flash[:notice] = "User Profile Udpate Successfully !"
    else
      flash[:alert] = @user.error.full_messsages
    end
    redirect_to tweets_user_path(@user)
  end

  def followings
    @followings = @user.followings.order(followers_count: :desc)
    # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order(tweets_count: :desc)
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.order(likes_count: :desc)
    # 基於測試規格，必須講定變數名稱
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def user_profile_params
    params.require(:user).permit(:introduction, :avatar, :name)
  end
  
end
