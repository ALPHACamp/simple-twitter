class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweets = Tweet.order(created_at: :desc)
    @users = User.order(followers_count: :desc).limit(10)
    @tweet = Tweet.new #寫一篇tweet
  end
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = '新增成功'
      redirect_to tweets_path
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      render action: :index
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
