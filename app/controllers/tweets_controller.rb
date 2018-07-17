class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweets = Tweet.order(created_at: :desc)
    @tweet = Tweet.new
    @users = User.all.order(followers_count: :desc).limit(10)
  end

  def create
    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      redirect_to tweets_path
      flash[:alert] = "not able to tweet"
    end
  end
  

  def like
    @tweet = Tweet.find(params[:id])
    @like = @tweet.likes.create(user: current_user)
    if @like.save
      redirect_to tweets_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    if likes.destroy_all
      redirect_to tweets_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
