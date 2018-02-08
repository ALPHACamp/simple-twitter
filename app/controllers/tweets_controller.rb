class TweetsController < ApplicationController

  def index
    @users = User.order(followers_count: :desc).limit(10)
    @tweets = Tweet.order(created_at: :desc).limit(10)
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      @tweets = Tweet.order(created_at: :desc).limit(10)
      render :index
    end
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
