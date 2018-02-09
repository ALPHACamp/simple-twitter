class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @user = current_user
    @replies = @tweet.replies.order("replies.created_at desc").all

    @reply = current_user.replies.new
  end

  def create
    @reply = current_user.replies.new(reply_params)
    if @reply.save
      flash[:notice] = "Reply posted."
    else
      flash[:alert] = "Something is wrong! Maximum reply length is 140 characters!"
    end
    redirect_to tweet_replies_path(current_user.replies.last.tweet_id)
  end

  private

  def reply_params
    params.require(:reply).permit(:tweet_id, :comment)
  end

end
