class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets  = Tweet.all
  end

  def create
  end

  def like
  end

  def unlike
  end

end
