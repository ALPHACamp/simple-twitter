class Admin::BaseController < ApplicationController
   before_action :authenticate_admin
   before_action :authenticate_user!
  
  
end
