class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id]) #確認推播物件
    @user = @tweet.user
    @reply = Reply.new
  end

  def create
  end

end
