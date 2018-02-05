class TweetsController < ApplicationController
before_action :authenticate_user!
  def index
    @tweets = Tweet.new
    @tweet_order = Tweet.order(created_at: :desc).limit(10)
  end

  def create
    @user= current_user
    @create_tweets = @user.tweets.create(tweet_params)
    if @create_tweets.save
      redirect_to root_path
    end
  end

  def like
  end

  def unlike
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end
end
