class TweetsController < ApplicationController
  def index
    if authenticate_user!
      redirect_to(new_user_session_path)
    end
    @users = User.order(followers_count: :desc).limit(10)
    @allusers = User.all
     # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    #3.使用者能瀏覽所有的推播 (tweet)
    @allTweets = Tweet.all
    @user = User.find(current_user.id)
    @tweet = Tweet.new
  end

  def create
    @user = User.find(current_user.id)
    @tweet = @user.tweets.build(tweet_params)
    @tweet.user = current_user
    @tweet.save!
    redirect_back(fallback_location: root_path)
  end

  def like
  end

  def unlike
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
