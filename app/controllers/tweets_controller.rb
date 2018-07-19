class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :unlike]
  def index
    @users = User.all
    @tweet = Tweet.new
    @tweets = Tweet.all
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "tweet was successfully created"
      redirect_to root_path
    else
      flash.now[:alert] = "tweet was failed to create"
      render :index
    end
  end

  def like
    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user).first
    likes.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description, :avatar)
  end

end
