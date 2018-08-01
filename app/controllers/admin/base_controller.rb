class Admin::BaseController < ApplicationController
	if current_user.admin? == false
    redirect_to root_path
  end
end
