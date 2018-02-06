class TweetsController < ApplicationController

  

  def index
    @users = User.order(followers_count: :desc).limit(10)
    @tweets = Tweet.order('created_at DESC')
    @tweet = Tweet.new
  end

  def create
    @tweet =  Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.save
    redirect_to tweets_path
  end

  def like
    tweet = Tweet.find(params[:id])
    tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    tweet = Tweet.find(params[:id])
    like = Like.where(user: current_user,tweet: tweet)
    like.destroy_all
    redirect_back(fallback_location: root_path)
  end

    private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

  def like_params
    params.require(:like).permit(:user_id, :tweet_id)
  end

end
