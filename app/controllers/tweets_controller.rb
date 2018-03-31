class TweetsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_tweet, :only => [:create ]

  def index
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(5)
    @user = current_user
    @recent_tweets = Tweet.order(created_at: :desc).limit(10)
    @pop_users = User.order(followers_count: :desc).limit(5)
    @tweet = Tweet.new
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
    #params.require(:tweet).permit(:description, :user_id)
    @user = current_user
    #@tweet = Tweet.new(tweet_params)
    @tweet = current_user.tweets.build(tweet_params)

    if @tweet.save
      flash[:notice] = "tweet was successfully created"
    else
      flash[:alert] = "tweet was failed to create"
    end
    redirect_to tweets_path
  end


  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    @tweet.likes_count = @tweet.likes_count + 1
    @tweet.save
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end


  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(user: current_user, tweet_id:params[:id])
    likes.destroy_all
    @tweet.likes_count = @tweet.likes_count - 1
    @tweet.save
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  #def replies
  #   @tweet = Tweet.find(params[:id])
  #  @replies = @tweet.replies
  #  @user = current_user
  #  @reply = Reply.new
  #  #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  #end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :intro, :role, :image, :name)
    end

    def check_userself
      if current_user!=@user
      redirect_to restaurants_path
      flash[:alert] = "您無編輯權限！"
      end
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:description, :user_id, :created_at, :updated_at)
    end

end
