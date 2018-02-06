class RepliesController < ApplicationController

  def index
  	@tweet = Tweet.find(params[:tweet_id])
  	@user = @tweet.user
  	@reply = Reply.new
  	@replies = Reply.where('tweet_id' => params[:tweet_id]).order(created_at: :desc)
  end

  def create
  	@tweet = Tweet.find(params[:tweet_id])
  	@reply = @tweet.replies.build(reply_params)
  	@reply.user = current_user
  	@reply.save!
  	redirect_back(fallback_location: root_path)
  end

  private
  def reply_params
  	params.require(:reply).permit(:comment)
  end

end
