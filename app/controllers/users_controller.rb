class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :tweets]

  def index
    @users = User.all
  end

  def tweets
    #看見某一使用者的推播牆，以及該使用者簡介
    @tweets = Tweet.where(user: @user).order(created_at: :desc)
    if @user.id == current_user.id
      @is_own_profile = true
    else
      @is_own_profile = false
    end
    @user = User.find(params[:id])
    @tweet_count = @user.tweet_count
    @following_count = @user.following_count
    @follower_count = @user.followers_count
    @like_count = @user.likes_count

  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def followings
    @followings = Followship.where(user_id:params[:id]).order(created_at: :desc)
    @user = User.find(params[:id])
    @tweet_count = @user.tweet_count
    @following_count = @user.following_count
    @follower_count = @user.followers_count
    @like_count = @user.likes_count
  end

  def followers
    @followers = Followship.where(following_id:params[:id]).order(created_at: :desc)
    @user = User.find(params[:id])
    @tweet_count = @user.tweet_count
    @following_count = @user.following_count
    @follower_count = @user.followers_count
    @like_count = @user.likes_count
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
