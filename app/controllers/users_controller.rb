class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id]) # 使用者個人頁面的 id，傳入  tamplate 在 follow / unfollow 按鈕處，當 following_id
    @tweets = Tweet.where(user_id: @user.id).order(created_at: :desc) # 回傳 array，v 端仍可直接用 each do 方法
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to :action => :edit, :id => @user
    else
      flash[:alert] = "User was failed to updated"
      render :edit
    end
  end

  #@followings # 基於測試規格，必須講定變數名稱
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  #@followers # 基於測試規格，必須講定變數名稱
  def followers
    @followers = @user.followers
  end

  def likes
    #@likes # 基於測試規格，必須講定變數名稱
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
