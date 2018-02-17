class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :followings, :followers, :likes, :tweets]



  def tweets
    @tweets = @user.tweets
  end

  def edit
    if @user != current_user
      redirect_to root_path
    end
  end

  def update
    @user.update(user_params)
    redirect_to tweets_user_path(@user)
  end

  def followings
    @followings=@user.followings.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers=@user.followers.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes=@user.likes # 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

  def set_user
    @user=User.find(params[:id])
  end

end
