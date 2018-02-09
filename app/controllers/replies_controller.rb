class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:id])
    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:id])
    @reply = current_user.replies.build(reply_params)
    @reply.tweet = @tweet
    if @reply.save
      redirect_back(fallback_location: root_path)
    else
      @reply.errors.each do |error, message|
        flash[:alert] = "#{error.capitalize} #{message}"
      end
      redirect_to replies_path
    end
  end

  private

  def reply_params
    params[:reply].permit(:comment)
  end
end
