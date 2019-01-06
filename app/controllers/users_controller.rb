class UsersController < ApplicationController
  before_action :set_user, only:  [:tweets, :edit, :update, :followings, :followers, :likes]


  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    if @user.id != current_user.id
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "user was successfully updated"
      redirect_to tweets_user_path(@user)
    else
      flash.now[:alert] = "user was failed to update"
      render :edit
    end
  end

  def followings
    @followings = @user.followings.includes(:followships).order("followships.created_at desc")
  end

  def followers
    @followers = @user.followers.includes(:followships).order("followships.created_at desc")
  end

  def likes
    @likes = @user.liked_tweets.includes(:likes).order("likes.created_at desc")
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
