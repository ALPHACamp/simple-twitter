class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @user = @tweet.user
    @replies = @tweet.replies.order(updated_at: :desc)
    
    @reply = Reply.new
  end




  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user

   if @reply.save
     flash[:notice] = 'Your reply saved'
     redirect_to tweet_replies_path(@tweet)
   else
     flash.now[:alert] = @reply.errors.full_messages.each{|msg| msg.class}
     @tweet = Tweet.find(params[:tweet_id])
     redirect_to tweet_replies_path(@tweet, reply_params)
   end
  end




  # def destroy
  #     @tweet = Tweet.find(params[:tweet_id])
  #     @reply = Reply.find(params[:id])
  #
  #     if @reply.user == current_user
  #       @reply.destroy
  #       redirect_to replies_user_path(@tweet)
  #     end
  #   end


    private

    def reply_params
      params.require(:reply).permit(:comment)
    end


end
