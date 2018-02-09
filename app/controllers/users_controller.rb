class UsersController < ApplicationController

  before_action :find_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    
    @tweets = @user.tweets.order('created_at DESC')

  end

  def edit
    
    if current_user != @user
      redirect_to tweets_user_path(@user)
      flash[:alert] = "你不是本人"
    end
  end

  def update
    
    @user.update(user_params)
    @user.save
    redirect_to tweets_user_path(@user)
  end

  def followings
    
    #@followings = @user.followings  # 基於測試規格，必須講定變數名稱
    @followings = User.where('followships.user_id = ?', @user.id).joins(:inverse_followships).merge(Followship.order(created_at: :desc))
  
  end

  def followers
    
    #@followers = @user.followers # 基於測試規格，必須講定變數名稱
    @followers = User.where('followships.following_id = ?', @user.id).joins(:followships).merge(Followship.order(created_at: :desc))

  end

  def likes
    
    #@likes = @user.like_tweets  # 基於測試規格，必須講定變數名稱
    @likes = Tweet.where('likes.user_id = ?', @user.id).joins(:likes).merge(Like.order(created_at: :desc))
  end

  private
  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
