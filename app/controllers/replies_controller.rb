class RepliesController < ApplicationController

  def index
    @replies = Reply.all
  end

  def create
  end

end
