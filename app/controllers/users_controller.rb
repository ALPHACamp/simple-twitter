class UsersController < ApplicationController
  before_action :set_user

  def tweets
    @tweets = @user.tweets
  end

  def edit
    #功能已併入devise頁面,但還是先寫起來放著
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    #功能已併入devise頁面,但還是先寫起來放著
    if @user.update(user_params)
      flash[:notice] = "更新成功"
      redirect_to edit_user_path
    else
      flash.now[:alert] = "更新失敗"
      render :edit
    end
  end

  def followings
    @followings = @user.followings.order('followships.created_at DESC')
    # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order('followships.created_at DESC') 
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.like_tweets # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end

end
