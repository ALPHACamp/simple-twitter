class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :likes, :followings, :followers]
  #before_action :set_user
  def tweets
    @tweets = @user.tweets.order(updated_at: :desc)
  end

  def edit
     unless @user == current_user
      redirect_to tweets_user_path(@user)
     end
  end

  def update
    @user.update(user_params)
    redirect_to tweets_user_path(@user)
  end

  def followings
    #@followings # 基於測試規格，必須講定變數名稱
    #@followings = @user.followings
    #@user = User.find(params[:id])
    @followings = @user.followings.order('followships.updated_at DESC')
    #@followings = @user.followings.includes(:followships).order("followships.created_at desc")
    
  end

  def followers
    #@followers # 基於測試規格，必須講定變數名稱
    @followers = @user.followers # 需至 User Model 自訂方法
  end

  def likes
    @likes = @user.like_tweets # 基於測試規格，必須講定變數名稱
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
  
end
