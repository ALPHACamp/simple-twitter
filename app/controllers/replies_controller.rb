class RepliesController < ApplicationController

  def index
    @replies = Replies.all.order(created_at: :desc)
  end

  def create
  end

end
