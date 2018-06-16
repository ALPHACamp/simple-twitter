class RepliesController < ApplicationController
 before_action :setup_tweet
  def index
    @replies = @tweet.replies.all
    @reply = @tweet.replies.new
  end

  def create
    @reply = @tweet.replies.new(reply_params)
    @reply.user = current_user
      if @reply.save
        flash[:notice] = '新增成功'
        redirect_to tweet_replies_path(@tweet)
      else
        @replies = @tweet.replies.all
        render action: :index
      end
  end


private

  def setup_tweet
    @tweet = Tweet.includes(:replies, :user).find(params[:tweet_id])
  end

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
