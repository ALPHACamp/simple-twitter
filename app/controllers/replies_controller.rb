class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @user = User.find(@tweet.user_id)
    @replies = Reply.where(:tweet_id => @tweet.id)
  end

  def create
    @reply = Reply.new(reply_params)
    @reply.user_id = current_user.id
    @reply.tweet_id = params[:tweet_id]
    if @reply.save      
      flash[:notice] = "reply was successfully created"
      redirect_to tweet_replies_path
    else
      flash.now[:alert] = "tweet was failed to create"
      render :index
    end
  end

    #----------------------private----------------------#

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
