class RepliesController < ApplicationController
before_action :set_action, only: [:index, :create]
  def index
    
    @replies = @tweet.replies.all
    @reply = Reply.new
  end

  def create
    @reply = @tweet.replies.build(comment_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_replies_path(@tweet)
  end

  private

  def set_action
    @tweet = Tweet.find(params[:tweet_id])
  end

  def comment_params
    params.require(:reply).permit(:comment)
  end
end


