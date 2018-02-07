class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
      flash[:notice] = "回覆成功！"
      redirect_to tweet_replies_path(@tweet)
    else
      @tweet = Tweet.find(params[:tweet_id])     
      flash[:alert] = "回覆不可以空白!!"
      redirect_to tweet_replies_path(@tweet)
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
