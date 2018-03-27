class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :followings, :followers, :likes]
 
  def tweets
    @tweets = @user.tweets.includes(:liked_users).order(created_at: :desc)
    
  end

  def edit
    if !@user == current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if !@user == current_user
      flash[:alert] = "Not allowed"
      redirect_back(fallback_loation: root_path)
    else 
      if @user.update(user_params)
        flash[:notice] = " Successfully updated"
       redirect_to root_path
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
        render :edit
      end
    end
  end

  def followings
    @followings = @user.followings.includes(:followships).order("followships.created_at desc")

    
  end

  def followers
    @followers = @user.followers.includes(:followships).order("followships.created_at desc")
  end

  def likes
    @liked_tweets = @user.liked_tweets.includes(:likes, :user, :liked_users).order("likes.created_at desc")
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
