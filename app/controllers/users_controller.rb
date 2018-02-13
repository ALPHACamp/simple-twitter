class UsersController < ApplicationController
  before_action :set_user
  def tweets  
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    if current_user != @user
      redirect_to tweets_user_path(params[:id]), alert: "You can not edit other user's profile!"
    end  
  end

  def update
      # only userself can update profile in right format
      if @user.update(user_params)
        redirect_to tweets_user_path(params[:id]), notice: "User's profile was successfully updated"
      else
        render :edit
      end  
  end

  def followings
    # 基於測試規格，必須講定變數名稱 
    @followings = @user.followings.includes(:followships).order('followships.created_at desc')
  end

  def followers
    # 基於測試規格，必須講定變數名稱
    @followers = @user.followers.includes(:followships).order('followships.created_at desc')    
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    @likes = @user.liked_tweets.includes(:likes).order('likes.created_at desc')
  end  
  ##############3
  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
