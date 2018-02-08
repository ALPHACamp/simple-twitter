class UsersController < ApplicationController
  before_action :set_user 
  before_action :correct_user, only: [:edit, :update]

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
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
    @followings = @user.followings.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
    render 'show_followings'  
  end

  def followers
    @title = "Followers"
    @followers = @user.followers.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
    render 'show_followers'
  end

  def likes
    @title = "Likes"
    @likes = @user.like_tweets.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
    render 'show_like'  
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
