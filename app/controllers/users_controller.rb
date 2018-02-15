class UsersController < ApplicationController

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
    if @user.update(user_params)
      flash[:notice] = "user was successfully updated."
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = "user was failed to updated."
      render :edit
    end
  end

  #我在追蹤誰
  def followings
    # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  #誰在追蹤我
  def followers
    # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  #tweet被喜歡的數量
  def likes
    # 基於測試規格，必須講定變數名稱
    @user = User.find(params[:id])
    @likes = Like.all.where(:user_id => current_user)
  end
  
  private

  def checkid
    @user = User.find(params[:id])
    unless current_user == @user
       flash[:alert] = "Not allow!"
       redirect_to tweets_user_path(current_user)
     end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
