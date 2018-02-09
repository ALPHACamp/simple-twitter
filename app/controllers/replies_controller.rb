class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
    @replies = @tweet.replies
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(comment: reply_params[:comment], user: current_user)
    if @reply.save
      flash[:notice] = "reply success!"
      redirect_to tweets_path
    else
      flash[:alert] = @reply.errors.full_messages.to_sentence
      redirect_back fallback_location: tweets_path
    end
  end


  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
