class RepliesController < ApplicationController
  before_action :set_tweet, only: [:index, :create]

  def index
    @user = User.find(@tweet.user_id)
    @replies = @tweet.replies
    @reply = Reply.new
  end

  def create
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

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end


  def comment_params
    params.require(:reply).permit(:comment)
  end


end
