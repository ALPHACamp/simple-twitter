class TweetsController < ApplicationController
  before_action :authenticate_user!
  

  def index
    @tweet = Tweet.new
    @tweets = Tweet.order(created_at: :desc).limit(10)
    @users = User.order(followers_count: :desc).limit(10)
  end

  def create
    @user = current_user
    @tweet = @user.tweets.new(tweet_params)
    @tweet.save!
    redirect_to tweets_path
  end

  def like
  end

  def unlike
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
