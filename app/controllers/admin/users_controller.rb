class Admin::UsersController < ApplicationController
	def index
		@users = User.all
		if current_user.admin? == false
	    redirect_to root_path
	  end
		
	end
	
end
