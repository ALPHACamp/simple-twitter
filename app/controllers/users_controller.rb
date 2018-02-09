class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :likes, :followings, :followers]
  def tweets
    @tweets = @user.tweets.includes(:like_users).order(created_at: :desc)
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(current_user), alert: "Can't edit other's profile"
    end
  end

  def update
    if @user == current_user
      if @user.update(user_params)
        redirect_to root_path, notice: "Profile Updated "
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
        render :edit
      end
    else
      redirect_to root_path, alert: "Can't edit other's profile"
    end
  end

  def followings
    @followings = @user.followings.includes(:followships).order("followships.created_at desc") # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.includes(:followships).order("followships.created_at desc") # 基於測試規格，必須講定變數名稱
  end
  def likes
    @likes = @user.like_tweets.includes(:likes, :user, :like_users).order("likes.created_at desc") # 基於測試規格，必須講定變數名稱
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
