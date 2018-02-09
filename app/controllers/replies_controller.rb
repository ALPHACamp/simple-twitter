class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies
    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = current_user.replies.build(reply_params)
    @reply.tweet = @tweet
    if @reply.save
      redirect_back(fallback_location: tweet_replies_path(@tweet))
    else
      @reply.errors.each do |error, message|
        flash[:alert] = "#{error.capitalize} #{message}"
      end
      redirect_to tweet_replies_path(@tweet)
    end
  end

  private

  def reply_params
    params[:reply].permit(:comment)
  end
end
