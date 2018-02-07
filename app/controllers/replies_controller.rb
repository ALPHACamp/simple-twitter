class RepliesController < ApplicationController

  def index
    @replies = Tweet.find(params[:tweet_id]).replies
  end

  def create
  end

end
