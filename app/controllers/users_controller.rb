class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def edit
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params) 
      flash[:notice] = "成功更新個人資料！"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = "資料更新失敗！"
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order('followships.updated_at DESC')
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order('followships.updated_at DESC') # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.like_tweets.order('likes.updated_at desc')
   
  end

  private
    
  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end


  end
