class UsersController < ApplicationController
  
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweet = @user.tweets.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def edit
    if @user != current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile was successfully updated"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = "Profile was failed to update"
      render :edit
    end
  end

  def followings
    # 基於測試規格，必須講定變數名稱
    # 該使用者的關注清單，排序依照追蹤紀錄成立的時間，愈新的在愈前面
    @followings = @user.followings.order('followships.created_at DESC')
  end

  def followers
    # 基於測試規格，必須講定變數名稱
    # 該使用者的跟隨者清單，排序依照追蹤紀錄成立的時間，愈新的在愈前面
    @followers = @user.followers.order('followships.created_at DESC')
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    # 該使用者 like 過的推播清單，排序依 like 紀錄成立的時間，愈新的在愈前面
    @likes = @user.liked_tweets.order('likes.updated_at DESC')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end

end
