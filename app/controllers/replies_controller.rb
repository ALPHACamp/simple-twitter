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
    else
      flash[:alert] = "Reply was failed to create. #{@reply.errors.full_messages.to_sentence}"
    end
    redirect_to tweet_replies_path(@tweet)
  end

  def update
    @reply = Reply.find(params[:id])
    @tweet = @reply.tweet

    if @reply.update(reply_params)
      flash[:notice] = "Reply was successfully updated."
    else
      flash[:alert] = "Reply was failed to update. #{@reply.errors.full_messages.to_sentence}"
    end
    redirect_to tweet_replies_path(@tweet)
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
    else
      flash[:alert] = "You are not authorized."
    end
    redirect_back(fallback_location: root_path)
  end

  private 

  def reply_params
    params.require(:reply).permit(:comment)
  end

  def set_tweet
    @tweet = Tweet.find_by_id(params[:tweet_id])
    if !@tweet
      redirect_to(root_path)
    end
  end
end
