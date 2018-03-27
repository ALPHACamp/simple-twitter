class RepliesController < ApplicationController

  def index
  	@tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies
  	@reply = Reply.new
    @user = @tweet.user
  end

	def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new(comment_params)
    @reply.tweet = @tweet
    @reply.user = current_user
    if @reply.save
      flash[:notice] = "成功回覆"
      redirect_back(fallback_location: tweet_replies_path(@tweet))
    else
      flash.now[:alert] = "回覆失敗"
      render :index
    end
  end

  private

  def comment_params
    params.require(:reply).permit(:comment)
  end

end
