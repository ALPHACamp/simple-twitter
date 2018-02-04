class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all;
    @tweet = Tweet.new;

    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users  = User.all.limit(10);
  end

  def create
    @tweet = Tweet.new(tweet_params);
    @tweet.user = current_user;
    if @tweet.save
      flash[:notice] = "Nice Tweet!"
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
  end

  def unlike
  end

  private

  def tweet_params
    params[:tweet].permit(:description);
  end

end
