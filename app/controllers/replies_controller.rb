class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:id])
    @replies = @tweet.replies
    @user = @tweet.user
    @reply = Reply.new
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end


  def create
    @tweet = Tweet.find(params[:id])
    @user = current_user
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user

    if @reply.save
      flash[:notice] = "Reply was successfully created"
    else
      flash[:alert] = "Reply was failed to create"
    end
    redirect_to replies_tweet_path
  end


  private
    def reply_params
      params.require(:reply).permit(:comment, :user_id, :tweet_id, :created_at, :updated_at)
    end

end
