class UsersController < ApplicationController
  before_action :set_user , only: [:tweets,:edit,:update,:followings, :followers]
  def tweets
    @tweets = @user.tweets.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def edit
    if current_user != @user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "資料更新成功"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end

  end

  def followings
    @user = User.find(params[:id])
    # 不確定
    @followings = @user.followings.order('followships.updated_at DESC')
  end

  def followers
    @user = User.find(params[:id])
    # 不確定
    @followers = @user.followers.order('followships.updated_at DESC')
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.order(created_at: :desc)
    #@likes_tweet = @user.liked_tweets.order('likes.updated_at DESC')
  end

  private 

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:introduction,:avatar)
  end
end
