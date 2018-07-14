class RepliesController < ApplicationController
  before_action :set_reply

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies.includes(:user).order(created_at: :desc)
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    if @reply.save
      flash[:notice] = "reply was successfully created"
      redirect_to tweet_replies_path(@tweet)     
    else
      @replies = @tweet.replies.order(created_at: :desc)
      render :index
    end

  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.find(params[:id])
    @reply.destroy
    redirect_to tweet_replies_path(@tweet) 
  end

  def reply_params
    params.require(:reply).permit(:comment)
  end

  def set_reply
    if  params[:id]
      @reply = Reply.find(params[:id])
    else
      @reply = Reply.new
    end
  end

end
