class UsersController < ApplicationController
  before_action :set_user, expect: [:update]

  def tweets
    # Tweets：排序依日期，最新的在前
    @tweets = @user.tweets.includes(:liked_users).order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to tweets_user_path(current_user)
      flash[:notice] = "#{current_user.name} was successfully updated"
    else
      render :edit
      flash[:alert] = "#{current_user.name} was failed to update"
    end
  end

  def followings
    # 基於測試規格，必須講定變數名稱
    # @followings = Followship.where(user_id: params[:id]).order(created_at: :desc)
    # Following：該使用者的關注清單，排序依照追蹤紀錄成立的時間，愈新的在愈前面
    @followings = @user.followings.includes(:followships).order("followships.created_at desc")
  end

  def followers
    # 基於測試規格，必須講定變數名稱
    # Follower：該使用者的跟隨者清單，排序依照追蹤紀錄成立的時間，愈新的在愈前面
    @followers = @user.followers.includes(:followships).order("followships.created_at desc")
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    @tweets = @user.liked_tweets.order(created_at: :desc)
    # Like：該使用者 like 過的推播清單，排序依 like 紀錄成立的時間，愈新的在愈前面
    @likes = @user.liked_tweets.includes(:likes).order("likes.created_at desc")
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
