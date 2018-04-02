class UsersController < ApplicationController
  before_action :set_tweet, only: [:tweets,:edit, :update,:likes]
  def tweets
    @user_tweets = User.find(params[:id]).tweets.order(created_at: :desc)
  end

  def update
    if @users.update_attributes(users_params)    
      flash[:notice] = "users was scuccessfully updated"
      redirect_to tweets_user_path(current_user)
    else
      flash.now[:alert] ="users was failed to update"
      render :edit
    end  
  end

  def followings
    @followings = User.find(params[:id]).followings.order('followships.created_at desc')# 基於測試規格，必須講定變數名稱
  end

  def followers
    # 基於測試規格，必須講定變數名稱
    @followers = User.find(params[:id]).followers.order('followships.created_at desc')
  end

  def likes
    @likes = User.find(params[:id]).liked_tweets.order('likes.created_at desc') # 基於測試規格，必須講定變數名稱
  end


  private

  def set_tweet
    @users = User.find(params[:id])    
  end

  def users_params
    params.require(:user).permit(:name, :introduction, :avatar)  
  end

end
