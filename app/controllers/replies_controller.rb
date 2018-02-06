class RepliesController < ApplicationController

  def index
     @tweet= Tweet.find(params[:id])
     @reply = Reply.new
     @reply_all = Reply.order(created_at: :desc).limit(10)
     @replyuser = current_user
  end

  def create
     @tweet= Tweet.find(params[:id])
     @replies = @tweet.replies.build(replies_params)
     @replies.user = current_user
    if @replies.save
      redirect_to replies_path(Tweet.find(params[:id]))
   end
  end

  private
def replies_params
  params.require(:reply).permit(:comment)
end
end
