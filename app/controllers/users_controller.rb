class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  #呈現用戶頁面，自己或他人
  def tweets
    @tweets = Tweet.where(:user_id => @user.id ).order(created_at: :desc)
  end

  #編輯自己的資料
  def edit
    unless @user == current_user
      redirect_to tweets_user_path(current_user), alert: "Not Allow!"
    end
  end

  #編輯好自己的資料好，上傳
  def update
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "user was successfully updated."
        redirect_to tweets_user_path(@user)
      else
        flash[:alert] = "user was failed to updated."
        render :edit
      end
    end
  end

  #我在追蹤誰
  def followings
    # 基於測試規格，必須講定變數名稱
    @followings = @user.followings.order(created_at: :desc)
  end

  #誰在追蹤我
  def followers
    # 基於測試規格，必須講定變數名稱
    @followers = @user.followers.order(created_at: :desc)
  end

  #tweet被喜歡的數量
  def likes
    # 基於測試規格，必須講定變數名稱
    @likes = Like.all.where(:user_id => current_user).order(created_at: :desc)
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
