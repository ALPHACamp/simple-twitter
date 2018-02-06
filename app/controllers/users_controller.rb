class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :update, :likes, :followings, :followers]

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    if @user != current_user 
      flash[:alert] = "You are not authorized."
      redirect_to tweets_user_path(current_user)
    end  
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile has been successfully updated"
      redirect_to tweets_user_path    
    else
      flash[:alert] = "Profile was failed to update. #{@user.errors.full_messages.to_sentence}"
      redirect_back(fallback_location: edit_user_path(@user))
    end  
  end

  def followings
    @followings = @user.followings.order('followships.created_at DESC')
     # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order('followships.created_at DESC')
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.order('likes.created_at DESC')
    # 基於測試規格，必須講定變數名稱
  end

  private 

  def set_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :description)
  end
end
