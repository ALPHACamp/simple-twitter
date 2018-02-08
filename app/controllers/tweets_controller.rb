class TweetsController < ApplicationController
before_action :set_tweet, only: [:edit, :update, :destroy, :like, :unlike]

  def index
    @users = User.all.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.page(params[:page]).per(30).order(created_at: :desc)
    @tweets = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params) do |tweet|
      tweet.user = current_user
      tweet.parent_id = params[:parent_id]
    end

  end

  def edit
     unless @user == current_user
       redirect_to tweets_user_path(@user)
     end
   end

  def update

    @tweet.update(tweet_params)
    flash[:notice] = "tweet was updated"
  end


  def destroy
    # @tweet = Tweet.find(params[:tweet_id])
    @tweet_id = params[:id]
    if @tweet.user == current_user
      @tweet.destroy
      redirect_to tweets_user_path(@user)
    end
    flash[:alert] = "tweet was deleted"
  end



  def like

    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: tweets_user_path)
  end

  def unlike

    like = Like.where(tweet: @tweet, user: current_user)
    like.destroy_all
    redirect_back(fallback_location: tweets_user_path)
  end






  private

  def set_tweet
     @tweet = Tweet.find(params[:id])
  end


  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
