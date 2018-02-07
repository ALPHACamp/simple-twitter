class RepliesController < ApplicationController

  def index
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_path(@tweet)
  end

  def reply_params
    params.require(:reply).permit(:content)
  end

end
