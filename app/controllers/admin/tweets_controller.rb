class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_admin
  before_action :set_tweet, :only => [:destroy]

  def index
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(10)
    @user = current_user
    @recent_tweets = Tweet.order(created_at: :desc).limit(10)
    @users =  User.order(followers_count: :desc).limit(10)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def destroy
    @tweet.destroy
    redirect_back(fallback_location: admin_root_path)
  end

  private

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
end
