class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to edit_user_path(@user)
  end

  def followings
    @followings = @user.followships.order(created_at: :desc)
  end

  def followers
    @followers = @user.inverse_followships.order(created_at: :desc)
  end

  def likes
    @likes = @user.likes.order(created_at: :desc)
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
