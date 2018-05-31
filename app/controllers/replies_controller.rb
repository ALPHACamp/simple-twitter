class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies 
    @user = @tweet.user

    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @user = current_user
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    
    if @reply.save
      flash[:notice] = "reply was successfully created"
      @tweet.replies_count += 1
      @tweet.save
    end

    redirect_to tweet_replies_path(@tweet)

  end


  def destroy

  end


  private
    def reply_params
      params.require(:reply).permit(:comment)
    end


end
