class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :tweets]

  def tweets
    @tweets = @user.tweets.all.order(created_at: :desc)
  end

  def edit
    unless @user == current_user
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "使用者資料更新成功"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "使用者資料更新失敗"
      render :action => :edit
    end
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
