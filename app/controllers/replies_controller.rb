class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies.order(created_at: :desc)
    @newReply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
      flash[:notice] = "Reply was successfully created"
      redirect_to tweet_replies_path(@tweet)
    else
      flash[:alert] = "Reply was failed to create"
      redirect_back(fallback_location: tweet_replies_path(@tweet) )
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
