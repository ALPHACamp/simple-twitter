class UsersController < ApplicationController

  before_action :get_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]
  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "user profile has been updated successfully"
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def followings
    @followings = @user.followings.order("followships.created_at desc")# 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order("followships.created_at desc") # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.order("likes.created_at desc")# 基於測試規格，必須講定變數名稱
  end

  private
  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introdution, :avatar)
  end   
end
