class UsersController < ApplicationController

  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.order(updated_at: :desc)
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to tweets_user_path(current_user)
      flash[:note] = "#{current_user.name} was successfully updated"
    else
      render :edit
      flash[:alert] = "#{current_user.name} was failed to update"
    end
  end

  def followings
    # 基於測試規格，必須講定變數名稱
    @followings = @user.followings.all.order('followships.created_at desc')
  end

  def followers
    # 基於測試規格，必須講定變數名稱
    @followers = @user.followers.all.order('followships.created_at desc')
  end

  def likes
    # 基於測試規格，必須講定變數名稱
    @tweets = @user.liked_tweets
    @likes = @tweets.all.order('likes.created_at DESC')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end



end
