class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.all.order(created_at: :desc);
    @tweet = Tweet.new;

    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users  = User.all.order(followers_count: :desc).limit(10);
  end

  def create
    @tweet = Tweet.new(tweet_params);
    @tweet.user = current_user;
    if @tweet.save
      flash[:notice] = "Nice Tweet!"
      current_user.tweets_count += 1
      current_user.save
      redirect_to tweets_path
    else
      if @tweet.errors.present?
        @tweet.errors.each do |error, message|
          flash[:alert] = "#{error.capitalize} #{message}"
        end
      else
        flash[:alert] = "Failed to tweet:("
      end
      redirect_to tweets_path
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    current_user.likes.create(tweet: @tweet)
    @tweet.user.likes_count += 1 # tweet author's "likes_count" plus 1 
    @tweet.user.save
    redirect_back(fallback_location: root_path)
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    @like = Like.where(user: current_user, tweet: @tweet)
    @like.destroy_all
    @tweet.user.likes_count -= 1
    @tweet.user.save
    redirect_back(fallback_location: root_path)
  end

  private

  def tweet_params
    params[:tweet].permit(:description);
  end

end
