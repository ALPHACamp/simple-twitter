class TweetsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users  = User.all
  end

  def create
  end

  def like
  end

  def unlike
  end

end
