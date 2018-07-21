class RepliesController < ApplicationController

  def index
  	@tweet = Tweet.find(params[:tweet_id])
  	@replies = @tweet.replies.order('created_at DESC')
  	@user = current_user
  	@reply = Reply.new
  end

  def create
  	@tweet = Tweet.find(params[:tweet_id])
  	@reply = @tweet.replies.build(reply_params)
  	@reply.user = current_user
  	if @reply.save
  		flash[:notice] = "Reply Created !"
  	else
  		flash[:alert] = @reply.errors.full_messages
  	end
  	redirect_to tweet_replies_path
  end

  private
  def reply_params
  	params.require(:reply).permit(:comment, :tweet_id, :user_id)
  end
end
