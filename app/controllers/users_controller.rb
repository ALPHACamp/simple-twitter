class UsersController < ApplicationController
  before_action :set_user 
  before_action :correct_user, only: [:edit, :update]

  def tweets
    @tweets = @user.tweets
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "成功完成編輯！"
      redirect_to root_path
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def followings
    @title = "Followings"
    @followings = @user.followings # 基於測試規格，必須講定變數名稱
    @follow = @followings 
    render 'follow_list'
  end

  def followers
    @title = "Followers"
    @followers = @user.followers # 基於測試規格，必須講定變數名稱
    @follow = @followers
    render 'follow_list'
  end

  def likes
    @title = "Likes"
    @likes = @user.liked_tweets # 基於測試規格，必須講定變數名稱
    render 'like_list'  
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar, :avatar_cache)
  end

  def correct_user
    redirect_to tweets_user_path unless @user == current_user
  end
end
