class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:like, :unlike]

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
    @users = User.all.order(followers_count: :desc).limit(10)
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to tweets_path
    else
      flash.now[:alert] = "tweet was failed to create"
      render :action => "index"
    end    
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path(@user)
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_to tweets_path(@user)
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
 
  def tweet_params
    params.require(:tweet).permit(:name, :description)
  end  
end
