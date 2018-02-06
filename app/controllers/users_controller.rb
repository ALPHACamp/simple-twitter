class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(Tweet.arel_table['created_at'].desc)
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "User profile has been updated"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = "Fail to update"
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(Followship.arel_table['created_at'].desc) # 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order(Followship.arel_table['created_at'].desc) # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.liked_tweets.order(Like.arel_table['created_at'].desc) # 基於測試規格，必須講定變數名稱
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
