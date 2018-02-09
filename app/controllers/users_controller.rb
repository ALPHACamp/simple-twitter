class UsersController < ApplicationController
  before_action :checkid, except: [:tweets]

  #呈現用戶頁面，自己或他人
  def tweets
    @user = User.find(params[:id])
    @tweets = Tweet.where(:user_id => @user.id )
  end

  #編輯自己的資料
  def edit
    @user = User.find(params[:id])
  end

  #編輯好自己的資料好，上傳
  def update
    @user = User.find(params[:id])
  end

  #我在追蹤誰
  def followings
    # 基於測試規格，必須講定變數名稱
    @followings = @user.followings
    @user = User.find(params[:id])
  end

  #誰在追蹤我
  def followers
    # 基於測試規格，必須講定變數名稱
    @followers = @user.followers
    @user = User.find(params[:id])
  end

  #tweet被喜歡的數量
  def likes
    @likes # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
  end
  
  private

  def checkid
    @user = User.find(params[:id])
    unless current_user == @user
       flash[:alert] = "Not allow!"
       redirect_to tweets_user_path(current_user)
     end
  end
end
