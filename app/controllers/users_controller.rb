class UsersController < ApplicationController

  before_action :set_user, only: [:tweets, :edit, :update, 
    :followings, :followers, :likes]

  def tweets    
    @tweets = Tweet.where(:user_id => params[:id])
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
    # 基於測試規格，必須講定變數名稱    
    @followings = Followship.where(:user_id => params[:id])
  end

  def followers
    # 基於測試規格，必須講定變數名稱
    @followers = Followship.where(:following_id => params[:id])
  end

  def likes
    # 基於測試規格，必須講定變數名稱    
    @likes = Like.where(:user_id => params[:id])

  end

  private 

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
