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
      redirect_to root_path
    else
      render :index
      flash[:alert] = "not able to tweet"
    end
  end
  

  def like
  end

  def unlike
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
