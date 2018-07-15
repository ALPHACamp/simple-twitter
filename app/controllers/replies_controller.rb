class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies
    @reply = Reply.new
    @user = current_user
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
      flash[:notice] = "successfully created reply"
    else
      flash[:alert] = @reply.errors.full_messages.to_sentence
    end
    redirect_to tweet_replies_path
    #redirect_back(fallback_location: root_path)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
end
