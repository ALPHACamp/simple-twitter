class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]  
 
  def tweets
    if @user == current_user
      @tweets = current_user.tweets.order(created_at: :desc)
    else
      @tweets = @user.tweets.order(created_at: :desc)
    end
  end

  def edit
    if current_user != @user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to edit_user_path(@user)
  end

  def followings # 基於測試規格，必須講定變數名稱
    @followings = @user.followships.order(created_at: :desc)
  end 

  def followers
    @followers = @user.followers.order(created_at: :desc)
  end

  def likes
    @likes = @user.liked_tweets.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
