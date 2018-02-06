class TweetsController < ApplicationController

  def index
    @users = User.order(followers_count: :desc).limit(10)
    @tweets = Tweet.all.order(created_at: :desc)    
  end

  def create    
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      flash[:notice] = "成功Tweet!"
      redirect_to tweets_path
    else
      flash.now[:alert] = "Tweet失敗"
      render :index
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user_id: current_user.id, tweet_id: @tweet.id)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet_id: @tweet.id, user_id: current_user.id)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  #----------------------private----------------------#

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end


end
