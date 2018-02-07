class RepliesController < ApplicationController

  def index
    # 透過tweet_replies_path(tweet)傳入個別tweet資料
    # 去找到tweet的相關資訊(作者/回覆)
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
  end

  def create
    
  end

end
