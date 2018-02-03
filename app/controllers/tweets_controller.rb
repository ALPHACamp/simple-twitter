class TweetsController < ApplicationController

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
