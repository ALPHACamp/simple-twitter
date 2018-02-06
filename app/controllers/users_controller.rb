class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update,:tweets,:likes]
  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit

  end

  def update
    if @user.update(user_params)
    redirect_to root_path
    else
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
    params.require(:user).permit(:name, :avatar,:introduction)
  end

end




