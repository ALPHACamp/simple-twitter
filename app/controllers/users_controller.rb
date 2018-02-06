class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def tweets
  end

  def show
    @tweets = Tweet.all.order(created_at: :desc).limit(10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
       flash[:notice] = "Updated!"
       redirect_to user_path(@user)
     else
      flash[:notice] = "Name can't be blank!"
      render :edit
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
