class UsersController < ApplicationController

  def tweets
    @user_id = User.find(params[:id])
    @tweets  = @user_id.tweets
    @followings = @user_id.followings
    @followers = @user_id.followers
  end

  def edit
    @user = User.find(params[:id])
    if (current_user != @user)
    redirect_to tweets_user_path(@user)
  end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to tweets_user_path(current_user)
  end

  def destroy
    @tweet_id  = Tweet.find(params[:id])
    @tweet_id.destroy
    redirect_to tweets_user_path(current_user)
  end
  def followings
    @user_id = User.find(params[:id])
    @followings = @user_id.followships.order(created_at: :desc)
    @following = @user_id.followships.order(created_at: :desc)
  end

  def followers
    @user_id = User.find(params[:id])
    @followers = @user_id.inverse_followships.order(created_at: :desc)
    @follower = @user_id.inverse_followships.order(created_at: :desc)
  end

  def likes
    @user_id = User.find(params[:id])
    @like = Like.order(created_at: :desc).limit(10)
    @likes = Like.order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
