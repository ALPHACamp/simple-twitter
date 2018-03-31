class UsersController < ApplicationController

  before_action :set_user, only: [:tweets, :edit, :update, :likes, :followings, :followers]

  def tweets
    # 使用者個人頁面的 id，傳入  tamplate 在 follow / unfollow 按鈕處，當 following_id
    @tweets = Tweet.where(user_id: @user.id).order(created_at: :desc) # 回傳 array，v 端仍可直接用 each do 方法
  end

  def edit
    unless @user == current_user
      flash[:alert] = "Cant edit others's profile"
      redirect_to tweets_user_path(current_user) # route 規格修改
    end
  end

  def update
    if @user == current_user
      if @user.update_attributes(user_params)
        flash[:notice] = "User was successfully updated"
        redirect_to edit_user_path(current_user)
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
        render :edit
      end
    else
      flash[:alert] = "Can't edit other's profile"
      redirect_to root_path
    end
  end

  #@followings # 基於測試規格，必須講定變數名稱
  def followings
    @followings = @user.followings.includes(:followships).order("followships.created_at desc")
  end

  #@followers # 基於測試規格，必須講定變數名稱
  def followers
    @followers = @user.followers.includes(:followships).order("followships.created_at desc")
  end

  #@likes # 基於測試規格，必須講定變數名稱
  def likes
    @likes = @user.liked_tweets.includes(:likes, :user, :liked_users).order("likes.created_at desc")
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
