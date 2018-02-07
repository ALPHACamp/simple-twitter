class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: params[:id]).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if current_user == @user
      if @user.update_attributes(user_params)
        redirect_to root_url, :notice => "個人資料更新成功"
      else
        render :action => :edit
      end
    else
      redirect_to root_url, :alert => "您非該使用者，無法更變該使用者資料"
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(created_at: :desc)
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :introduction, :avatar)
  end


end
