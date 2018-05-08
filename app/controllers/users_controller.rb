class UsersController < ApplicationController

  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.all.order(created_at: :desc)
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile was successfully updated"
      redirect_to tweets_user_path(@user)
    else
      flash[:notice] = "Your profile was failed to update"
      render :edit 
    end
  end

  def followings
    @followings = @user.followings.order("followships.created_at DESC") # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order("followships.created_at DESC") # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.all.order("likes.created_at DESC") # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
