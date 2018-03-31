class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]

  def index
    @users = User.order(followers_count: :desc).limit(10)    
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "Tweet was successfully created"
      redirect_back(fallback_location: tweets_path)
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      redirect_back(fallback_location: tweets_path)
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