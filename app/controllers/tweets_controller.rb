class TweetsController < ApplicationController
  def index
  	@users = User.order(followers_count: :desc).includes(:followers).limit(10)
  	@tweet = Tweet.new
    @tweets = Tweet.order(created_at: :desc)
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
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path

  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_to tweets_path

  end
  private
  def tweet_params
		params.require(:tweet).permit(:description)
	end

end
