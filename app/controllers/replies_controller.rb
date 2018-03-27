class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
    @user = @tweet.user
    @replies = @tweet.replies
    @tweets = Tweet.all.order(created_at: :desc).limit(10)
    @followings = @user.followings
    @followers = @user.followers
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_parmas)
    @reply.user = current_user
    if @reply.save
       flash[:notice] = "Reply created!"
       redirect_back(fallback_location: root_path)
     else
      flash[:alert] = @reply.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end

  end

  private

  def reply_parmas
    params.require(:reply).permit(:comment)
  end

end
