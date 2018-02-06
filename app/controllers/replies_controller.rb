class RepliesController < ApplicationController
  before_action :set_tweet, only: [:index, :create] 

  def index
    @replies = @tweet.replies.order(created_at: :desc)
    @reply = Reply.new
  end

  def create
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user

    if @reply.save
      flash[:notice] = "Reply was successfully created"
      redirect_to tweet_replies_path(@tweet)
    else
      flash[:alert] = "Reply was failed to create"
      render tweet_replies_path(@tweet)
    end
  end

  def destroy
    @reply = Reply.find(params[:id])

    if @reply.user == current_user   
      @tweet = @reply.tweet
      @reply.destroy

      if @reply.present?
        flash[:notice] = "reply was successfully deleted."
      else
        flash[:alert] = "reply does not exist."
      end
      redirect_back(fallback_location: root_path)
      
    else
      flash[:alert] = "You are not authorized."
      redirect_back(fallback_location: root_path)
    end
  end

  private 

  def reply_params
    params.require(:reply).permit(:comment)
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
