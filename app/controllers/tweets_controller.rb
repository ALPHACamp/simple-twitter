class TweetsController < ApplicationController
  def index
    @tweets = Tweet.includes(:user, :likes).all

    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = '新增成功'
      redirect_to tweets_path
    else
      @tweets = Tweet.includes(:user, :likes).all
      render action: :index
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    current_user.liked_tweets << @tweet
    redirect_to tweets_path
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    current_user.liked_tweets.delete(@tweet)
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
