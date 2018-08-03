class UsersController < ApplicationController
before_action :set_user, only: [:edit, :update, :followings, :followers, :likes, :tweets]
  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.includes(:user).order("tweets.created_at desc")
  end
  
  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to edit_user_path(@user)
  end

  def followings
    # For ordering on the attribute of an associated model you have to include it:
    @followings = @user.followings.includes(:followships).order("followships.created_at desc") # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.includes(:followships).order("followships.created_at desc") # 基於測試規格，必須講定變數名稱
    @user.followers_count
  end

  def likes
    @likes = @user.liked_tweets.includes(:likes).order("likes.created_at desc")
    # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end

end
