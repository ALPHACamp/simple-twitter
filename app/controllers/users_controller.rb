class UsersController < ApplicationController
	before_action :set_user, only: [ :edit, :update, :tweets,:followings,:followers,:likes]
  def tweets
    @followings = @user.followings.order(created_at: :desc)
    @followers = @user.followers.order(created_at: :desc)
    @likes = @user.likes.order(created_at: :desc)
    @tweets = @user.tweets
    @order_user_tweets = @user.tweets.order(created_at: :desc)
  end
  def followings
    @followings = @user.followings.order('followships.created_at DESC')
    @followers = @user.followers
    @likes = @user.likes.order(created_at: :desc)
    @tweets = @user.tweets
  end
  def followers
    @followers = @user.followers.order('followships.created_at DESC')
    @followings = @user.followings
    @likes = @user.likes.order(created_at: :desc)
    @tweets = @user.tweets
  end

  def likes
    @followings = @user.followings
    @followers = @user.followers
    @likes = @user.liked_tweets.order('likes.created_at DESC')
    @tweets = @user.tweets
  end
  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user), alert: "Can't edit other's profile"
    end
  end
  

  def update
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "Profile updated"
        redirect_to root_path
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
        render :edit
      end
    else
      flash[:alert] = "Can't edit other's profile"
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end

