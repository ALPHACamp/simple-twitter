class TweetsController < ApplicationController
	before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  def index
  	@users = User.all
  	@tweet = Tweet.new
    @tweets = Tweet.all
    @rank_tweets = Tweet.order(followers_count: :desc).limit(10)
  	# 新增一組空白資料給表單，首頁為index，＠tweet傳入表單的實例變數
    # @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end
  
  def create
    @user = current_user
    @tweet= @user.tweets.build(tweet_params)
		@tweet.save!
  	if @tweet.save
  		flash[:notice] = "tweet is successfully create"
  		redirect_to tweets_path
  	else
  		flash.now[:alert] = "tweet is failed to create"
  		render :new
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
