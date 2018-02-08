class TweetsController < ApplicationController
  before_action :authenticate_user!
  

  def index
    @tweet = Tweet.new
    @tweets = Tweet.order(created_at: :desc).limit(10)
    @users = User.order(followers_count: :desc).limit(10)
  end

  def create
    @user = current_user
    @tweet = @user.tweets.new(tweet_params)
    @tweet.save!
    redirect_to tweets_path
  end

  def like
    @tweet = Tweet.find(params[:id])
    @like = current_user.likes.build(tweet_id: params[:id])
    if @like.save
      flash[:notice] = "Successfully liked"
        current_user.increment!(:likes_count)
        @tweet.increment!(:likes_count)
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @like.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def unlike
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
