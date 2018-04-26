class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.includes(:liked_users).order(created_at: :desc)
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user), alert: "Not Allow!"
    end
  end

  def update
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "user was successfully updated."
        redirect_to tweets_user_path(@user)
      else
        flash[:alert] = "user was failed to updated."
        render :edit
      end
    end
  end

  #我在追蹤誰
  def followings
    # 基於測試規格，必須講定變數名稱
    @followings = @user.followings.includes(:followships).order("followships.created_at desc")
  end

  #誰在追蹤我
  def followers
    # 基於測試規格，必須講定變數名稱
    @followers = @user.followers.includes(:followships).order("followships.created_at desc")
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    @likes = @user.like_tweets.includes(:likes, :user, :liked_users).order("likes.created_at desc")
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
