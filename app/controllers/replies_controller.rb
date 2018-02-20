class RepliesController < ApplicationController

  before_action :set_tweet, only: [:index, :create]

  # 在reply的首頁裡，看到某個特定編號的推播
  # 設定推播下全部的回覆存進回覆這個變數
  def index
  	@replies = @tweet.replies
  	@reply = Reply.new
  end

  def create
  	@reply = @tweet.replies.build(reply_params)
  	@reply.user = current_user
  	if @reply.save
  		flash[:notice] = "回覆成功"
  		redirect_to tweet_replies_path(@tweet)
  	else
  		flash[:alert] = "回覆失敗了，內容不可以空白不填喔"
  		redirect_to tweet_replies_path(@tweet)
  	end
  end	

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def reply_params
  	params.require(:reply).permit(:comment)
  end	

end
