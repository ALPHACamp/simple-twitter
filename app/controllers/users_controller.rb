class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.order(created_at: :desc).page(params[:page]).per(10)
    @followers = @user.followers
    @followings = @user.followings
  end

  def edit
    unless @user == current_user
      flash[:alert] = "Not allow!"
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    flash[:success] = "Great! Your profile was updated successfully."
    redirect_to tweets_user_path(@user)
  end

  def followings
    @followings = @user.followings.order(created_at: :desc).limit(10)
  end

  def followers
    @followers = @user.followers.order(created_at: :desc).limit(10)
  end

  def likes
    @likes = @user.likes.order(created_at: :desc).limit(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
