class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies.all
    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
       flash[:notice] = "Reply created!"
       redirect_to tweet_replies_path(@tweet)
     else
      flash[:alert] = @reply.errors.full_messages.to_sentence
      redirect_to tweet_replies_path(@tweet)
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
