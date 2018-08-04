class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes] 

  def tweets
    @tweets = @user.tweets.all.order(created_at: :desc).page(params[:page]).per(10)
    @likes = @user.likes
    @followings = @user.followings
    @followers = @user.followers
  end

  def edit
     unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Profile Update"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def followings
    @followings = @user.followings.order('followships.created_at desc')# 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order('followships.created_at desc')# 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.likes.order(created_at: :desc)# 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar )
  end

end
