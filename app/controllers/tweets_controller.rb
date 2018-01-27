class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets = Tweet.all

    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = '新增成功'
      redirect_to tweets_path
    else
      @tweets = Tweet.all
      render action: :index
    end
  end
end
