class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]
  def index
    @tweets = Tweet.order(created_at: :desc)
    @users = User.order(followers_count: :desc).limit(10)
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweet successfully!!!"
      redirect_to root_path
    else
      flash[:alert] = "Your tweet is more than 140 characters!!!Please simplify your tweet."
      render :index
    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_back fallback_location: root_path
  end

  def unlike
    like = Like.where(tweet: @tweet, user: current_user)
    like.destroy_all
    redirect_back fallback_location: root_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
