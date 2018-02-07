class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = Tweet.where(user: @user)
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(created_at: :desc)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followships.order(created_at: :desc)
  end

  def likes
    @user = User.find(params[:id])
    @likes  =  @user.liked_tweets.order(created_at: :desc)
  end

end
