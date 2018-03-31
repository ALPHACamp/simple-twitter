class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :likes, :followings, :followers]

  def tweets
    @tweets = @user.tweets
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
    @followings = @user.followings.order(created_at: :desc)
  end

  def followers
    @followers = @user.followers.order(created_at: :desc)
  end

  def likes
    @likes = @user.likes.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
