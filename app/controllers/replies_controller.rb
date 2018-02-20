class RepliesController < ApplicationController

  # 在reply的首頁裡，看到某個特定編號的推播
  # 設定推播下全部的回覆存進回覆這個變數
  def index
  	@tweet = Tweet.find(params[:tweet_id])
  end

  def create
  end

end
