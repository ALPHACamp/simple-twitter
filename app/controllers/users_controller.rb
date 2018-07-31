class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :tweets, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets
    @order_user_tweets = @user.tweets.order(created_at: :desc)
    @followings = @user.followings
    @followers = @user.followers
    @likes = @user.likes

  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end


  def update
    @user.update(user_params)
    redirect_to tweets_user_path(@user)
  end

  def followings
    @followings = @user.followings.order('followships.created_at DESC')
    # 基於測試規格，必須講定變數名稱
    @tweets = @user.tweets
    @followers = @user.followers
    @likes = @user.likes
  end

  def followers
    @followers = @user.followers.order('followships.created_at DESC')
    # 基於測試規格，必須講定變數名稱
    @tweets = @user.tweets
    @followings = @user.followings
    @likes = @user.likes
  end

  def likes
    @likes = @user.liked_tweets.order('likes.created_at DESC')
    # 基於測試規格，必須講定變數名稱
    @tweets = @user.tweets
    @followings = @user.followings
    @followers = @user.followers
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end


end
