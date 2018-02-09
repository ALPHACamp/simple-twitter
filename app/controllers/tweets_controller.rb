class TweetsController < ApplicationController
before_action :authenticate_user!
  def index
    @tweet = Tweet.new
    @tweets= Tweet.order(created_at: :desc)
    @tweet_order = Tweet.order(created_at: :desc).limit(10)
    @user_all= User.all
    @users= User.order(followers_count: :desc)
    @user_followers_count = User.order(followers_count: :desc)
  end

  def create
    @user= current_user
    @create_tweets = @user.tweets.create(tweet_params)
    if @create_tweets.save
      redirect_to tweets_path
    end
  end

  def like
    @tweet_id = Tweet.find(params[:id])
    @tweet_id.likes.create!(user: current_user)
    redirect_to tweets_path  # 導回上一頁
  end

  def unlike
    @tweet_id = Tweet.find(params[:id])
    likesx = Like.where(tweet: @tweet_id , user: current_user)
    likesx.destroy_all
    redirect_to tweets_path
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end
end
