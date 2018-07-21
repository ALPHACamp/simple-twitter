class TweetsController < ApplicationController
  before_action :find_tweet, only: [:like, :unlike]

  def index
    @users = User.order(followers_count: :desc).first(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweet = Tweet.new
    @tweets = Tweet.order(created_at: :desc)
  end

  def create
  	@tweet = current_user.tweets.build(tweet_params)
    @tweets = Tweet.order(created_at: :desc)
  	if @tweet.save
  		flash[:notice] = 'Tweet is created successfully !'
  		render "index"
  	else
  		flash[:alert] = @tweet.errors.messages
  		redirect_to tweets_path
  	end
  end

  def like
    @like = Like.new(user_id: current_user.id, tweet_id: @tweet.id)
    if @like.save!
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = like.errors.messages
    end
  end

  def unlike
    @like = Like.find_by(user_id: current_user.id, tweet_id: @tweet.id)
    if @like
    @like.destroy
    redirect_back(fallback_location: root_path)
    end
  end

  private
  def tweet_params
  	params.require(:tweet).permit(:description, :user_id)
  end

  def find_tweet
    @tweet = Tweet.find(params[:id])
  end
end
