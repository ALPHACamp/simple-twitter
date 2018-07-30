class RepliesController < ApplicationController
	def index
		@replies = Reply.all
		@tweet = Tweet.find(params[:tweet_id])
		@reply = Reply.new
	end
  def create
		@tweet= Tweet.find(params[:tweet_id])
		@reply= @tweet.replies.build(reply_params)
		@reply.user= current_user
		@reply.save!
	  redirect_to tweet_replies_path(@tweet)
	end

	def destroy
		@tweet= Tweet.find(params[:tweet_id])
		@reply = Reply.find(params[:id])

		if current_user.admin?
			@reply.destroy
			redirect_to tweets_user_path(user)
		end
	end

	private
	def reply_params
		params.require(:reply).permit(:comment)
	end
end
