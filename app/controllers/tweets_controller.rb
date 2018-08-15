class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order('created_at desc')
    @users = User.all.order(followers_count: :desc).limit(10)
    @tweet = Tweet.new
  end

  def create
    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = "Successfully tweet"
      redirect_to tweets_path
    elsif @tweet.errors.any?
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      redirect_to tweets_path
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    like = Like.where(tweet: @tweet, user: current_user)
    like.destroy_all
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
