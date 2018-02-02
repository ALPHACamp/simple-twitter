class Admin::TweetsController < Admin::BaseController

  before_action :find_tweet, only: [:delete]

  def index
    @tweets = Tweet.all
  end

  def destroy
  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = @tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    tweet.save
    flash[:notice] = "Add a new tweet"
    redirect_to admin_tweets_path
  end

  def destroy
    find_tweet
    @tweet.destroy
    flash[:notice] = "delete success"
    redirect_to admin_tweets_path
  end


  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

  def find_tweet
    @tweet = Tweet.find(params[:id])
  end



end
