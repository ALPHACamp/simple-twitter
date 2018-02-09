class RepliesController < ApplicationController
  before_action :set_reply, only: [:index, :create]

  def index
    @user = @tweet.user
    @replies = Reply.all
    @reply = Reply.new
  end

  def create
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save
    redirect_back(fallback_location: root_path)
  end

  private

  def set_reply
    @tweet = Tweet.find(params[:tweet_id])
  end

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
