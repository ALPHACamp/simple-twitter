class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]
  def index
    @users = User.all.sort_by {|user| user.followers.size}.reverse.first(10)
    @tweet = Tweet.new
    @tweets = Tweet.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    user = current_user
    if @tweet.save
      user.count_tweets
      flash[:notice] = "tweet was successfully created"
      redirect_to tweets_path
    else
      flash.now[:alert] = "tweet was failed to create"
      render :index
    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user).first
    likes.destroy
    redirect_to tweets_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description, :avatar)
  end

end
