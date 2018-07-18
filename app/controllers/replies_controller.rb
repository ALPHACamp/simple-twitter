class RepliesController < ApplicationController

  def index
    @reply = Reply.find(params[:tweet_id])
  end

  def create
  end

end
