class RepliesController < ApplicationController

  def index
    @tweets = Tweet.all.where(id: params[:tweet_id])
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies.all.order(created_at: :asc)
    @reply = Reply.new
  end

  def create
    @tweets = Tweet.all.where(id: params[:tweet_id])
    @tweet = Tweet.find(params[:tweet_id])
    @replies = Reply.all.where(tweet_id: params[:tweet_id])
    
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    
    if @reply.save
      flash[:notice] = "Reply was successfully created"
      redirect_to tweet_replies_path(@tweet)
    else
      flash.now[:alert] = "Reply can't be blank or longer than 140 characters"
      render :index
    end
  end




  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
