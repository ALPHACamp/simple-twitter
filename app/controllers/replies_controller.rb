class RepliesController < ApplicationController

  before_action :set_tweet, only: [:index, :create]

  def index
  	@replies = @tweet.replies # 在reply的首頁裡，看到某個特定編號的推播
  	@reply = Reply.new # 設定推播下全部的回覆存進回覆這個變數
    @user = @tweet.user # 跟 replies/index.html.erb 的 Tweet.count 有關
    @tweets = @user.tweets # 跟 replies/index.html.erb 的 Tweet.count 有關
    @likes = @user.likes # like 的計數
    @followings = @user.followings # following 的計數
    @followers = @user.followers # 追蹤自己的人
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
