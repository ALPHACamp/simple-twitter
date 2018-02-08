class RepliesController < ApplicationController

  def index
    @tweet =Tweet.find(params[:tweet_id])
    @user = User.find(@tweet.user_id)
    @replies = @tweet.replies
    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(comment_params)
    @reply.user = current_user
    if @reply.save
      flash[:notice] = "Reply was successfully created"
      redirect_back(fallback_location: tweet_replies_path)
    else
      flash[:alert] = @reply.errors.full_messages.to_sentence
      redirect_back(fallback_location: tweet_replies_path)
    end


  end

  def comment_params
    params.require(:reply).permit(:comment)
  end


end
