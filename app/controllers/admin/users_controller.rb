class Admin::UsersController < ApplicationController
	def index
		@users = User.order(tweets_count: :desc)
		if current_user.admin? == false
	    redirect_to root_path
	  end
		
	end
	
end
