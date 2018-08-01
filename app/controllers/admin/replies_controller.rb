class Admin::RepliesController < ApplicationController
	def index
		@replies = Reply.order(created_at: :desc)
		@tweet = Tweet.find(params[:tweet_id])
		if current_user.admin? == false
	    redirect_to root_path
	  end
		
	end
  

	def destroy
		@tweet= Tweet.find(params[:tweet_id])
		@reply = Reply.find(params[:id])

		if current_user.admin?
			@reply.destroy
			redirect_to admin_tweet_replies_path(@tweet)
		end
	end
end
