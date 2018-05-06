class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :tweets, :followings, :followers, :likes]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    if @user == current_user
      render  :action => :edit
    else
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def tweets
  end

  def followings
    @followings = @user.followings
  end

  def followers
    @followers = @user.followers
  end

  def likes
    @likes = @user.liked_tweets
  end

  private
     
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end    
end
