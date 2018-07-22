class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :tweets, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    #@user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path
    end
  end

  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to tweets_user_path
      flash[:notice] = "user was successfully updated"
    else
      render :edit
      flash[:alert] = "user was failed to update"
    end
  end

  def followings
    @followings = @user.followings.order(created_at: :desc)# 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
  end

  def admin?
    self.role == "admin"
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
