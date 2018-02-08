class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.order('created_at DESC')
    #@following_count =
    #@follower_count =
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path
      flash[:alert] = "你不是本人"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.save
    redirect_to tweets_user_path(@user)
  end

  def followings
    @user = User.find(params[:id])
    #@followings = @user.followings  # 基於測試規格，必須講定變數名稱
    @followings = User.where('followships.user_id = ?', @user.id).joins(:inverse_followships).merge(Followship.order(created_at: :desc))
  
  end

  def followers
    @user = User.find(params[:id])
    #@followers = @user.followers # 基於測試規格，必須講定變數名稱
    @followers = User.where('followships.following_id = ?', @user.id).joins(:followships).merge(Followship.order(created_at: :desc))

  end

  def likes
    @user = User.find(params[:id])
    #@likes = @user.like_tweets  # 基於測試規格，必須講定變數名稱
    @likes = Tweet.where('likes.user_id = ?', @user.id).joins(:likes).merge(Like.order(created_at: :desc))
  end

  private
  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end


end
