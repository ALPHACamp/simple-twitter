class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]

  def tweets
    @tweets = @user.tweets.order(Tweet.arel_table['created_at'].desc)
  end

  def edit
    if current_user != @user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "User profile has been updated"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = "Fail to update"
      render :edit
    end
  end

  def followings
    @followings = @user.followings.order(Followship.arel_table['created_at'].desc) # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order(Followship.arel_table['created_at'].desc) # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.order(Like.arel_table['created_at'].desc) # 基於測試規格，必須講定變數名稱 # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
