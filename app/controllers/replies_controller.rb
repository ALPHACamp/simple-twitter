class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies.all
    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(comment: reply_params[:comment], user: current_user)
    if @reply.save
      redirect_back fallback_location: root_path, notice: "reply success"
    else
      flash[:alert] = @reply.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  private
  def reply_params
    params.require(:reply).permit(:comment)
  end
end
