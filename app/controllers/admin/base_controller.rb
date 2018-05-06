class Admin::BaseController < ApplicationController
  private

    def authenticate_admin
      unless current_user.admin?
        flash[:alert] = 'Not allow!'
        redirect_to root_path
      end
    end
end
