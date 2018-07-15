class UsersController < ApplicationController
  before_action :set_user, only:[:tweets, :edit, :update, :followers, :followings, :likes]
  def tweets
    @tweets = @user.tweets.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "successfull updated"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def followings
    @followings = @user.followings
    @users = @followings
    # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers
    @users = @followers
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets
    @tweets = @likes.order(created_at: :desc).page(params[:page]).per(10)
    # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar ,:name, :introduction)
  end
end
