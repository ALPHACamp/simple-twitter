class UsersController < ApplicationController

  before_action :set_user

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    unless @user === current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to tweets_user_path(current_user)
    else
      render :edit
    end
  end

  def followings
    @followings = @user.followings.all.order(created_at: :desc)
  end

  def followers
    @followers = @user.followers.all.order(created_at: :desc)
  end

  def likes
    @tweets = @user.liked_tweets
    @likes = @tweets.all.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
