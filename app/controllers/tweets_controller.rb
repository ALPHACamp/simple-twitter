class TweetsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_tweet, only: [:like, :unlike]

  def index
    @tweets = Tweet.order(created_at: :desc).limit(20)
    @tweet = Tweet.new
    @users = User.all
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      redirect_to tweets_path
    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
