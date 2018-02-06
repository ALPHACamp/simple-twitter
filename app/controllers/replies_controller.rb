class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:id])
    @replies = Reply.where(tweet_id: params[:id])
    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:id])
    @reply = Reply.new(reply_params)
    @reply.user_id = current_user.id
    @reply.tweet_id = @tweet.id
    if @reply.save
      flash[:notice] = "留言成功！"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @reply.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
