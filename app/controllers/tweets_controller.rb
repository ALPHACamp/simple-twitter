class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users=User.all # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets=Tweet.all
    @tweet=Tweet.new
  end

  def create
    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
    @tweet.save!
    redirect_to root_path
  end

  def like
  end

  def unlike
  end

  def replies
    @tweet=Tweet.find(params[:id])
    @replies=Tweet.find(params[:id]).reply
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end

end
