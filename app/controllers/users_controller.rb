class UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :tweets, :followings, :followers, :likes]

  def tweets
    @tweets = Tweet.where('user_id' => params[:id]).order(created_at: :desc)
  end

  def edit
    if @user != current_user 
      redirect_to tweets_user_path(@user)
      flash[:alert] = "You cannot edit other users"
    end
  end

  def update
    
    if @user.update(user_params)
      redirect_to edit_user_path(@user)
      flash[:notice] = "user was successfully updated"
    else
      redirect_to edit_user_path(@user)
      flash[:alert] = "user cannot be updated because you missed some fields"
    end
    
  end

  def followings
    @followings = @user.followings.order(created_at: :desc)
    
  end

  def followers
    @followers = @user.followers.order(created_at: :desc)
  end

  def likes
    @likes = @user.liked_tweets.order(created_at: :desc)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
