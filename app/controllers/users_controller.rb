class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers, :likes]
  before_action :set_count, only: [:show, :tweets, :followings, :followers, :likes]
  

  def tweets
    @tweets = @user.tweets
    
  end

  def edit
    if !@user == current_user
      redirect_to user_path(@user)
    end
  end

  def show

  end


  def update
    @user.update(user_params)
    redirect_to user_path
  end

  def followings
    @followings = @user.followings

    
  end

  def followers
    @followers = @user.followers
  end

  def likes
    @likes = @user.likes
    @liked_tweets = @user.liked_tweets
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_count
    @tweets = @user.tweets
    @followings = @user.followings
    @followers = @user.followers
    @likes = @user.likes
  end


  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
