class LikesController < ApplicationController

	def create
		@tweet = Tweet.find(params[:tweet_id])
		@like = current_user.likes.build(tweet_id: params[:tweet_id])
		if @like.save
	  		flash[:notice] = "Successfully liked"
	      	current_user.increment!(:likes_count)
	      	@tweet.increment!(:likes_count)
		    redirect_back(fallback_location: root_path)
	  	else
	  		flash[:alert] = @like.errors.full_messages.to_sentence
		    redirect_back(fallback_location: root_path)
	  	end
	end

	def destroy
	end

end