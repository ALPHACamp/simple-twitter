class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :tweets]

  def tweets
    # set_user

    # 顯示該使用者的推文
    @tweets = @user.tweets
  end

  def edit
    # before_action set_user

    # 讓使用者無法進入其他使用者的編輯頁面
    if @user == current_user
      # allow to edit
    else
      redirect_to tweets_user_path(@user.id)
    end
  end

  def update
    # before_action set_user

    if @user.update(user_params)
      flash[:notice] = "User data was successfully update."
      redirect_to tweets_user_path(@user.id)
    else
      flash.now[:alert] = "User was failed to update!"
      render :edit
    end
  end

  def followings
    # 基於測試規格，必須講定變數名稱
    @followings
  end

  def followers
    # 基於測試規格，必須講定變數名稱
    @followers
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    @likes
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
