class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users=User.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets=Tweet.order(created_at: :desc)
    @tweet=Tweet.new
  end

  def create
    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
    @tweet.save!
    @user.update(:tweets_count => @user.tweets.count)
    @user.save!
    redirect_to root_path
  end

  def like
    @tweet=Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_to root_path
  end

  def unlike
    @tweet=Tweet.find(params[:id])
    @like = Like.where(user: current_user, tweet: @tweet).first
    @like.destroy
    redirect_to root_path
  end

  def replies
    @tweet=Tweet.find(params[:id])
    @replies=Tweet.find(params[:id]).replies
    @reply=Reply.new
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description, :user_id)
  end

end
