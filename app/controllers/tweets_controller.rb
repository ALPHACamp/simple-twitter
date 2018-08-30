class TweetsController < ApplicationController

  def index
    
    @tweet = Tweet.new
    
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "You Tweet was successfully created"
      redirect_to root_path
    else
      flash.now[:alert] = "Your Tweet was failed to create"
      render :index
    end
  end

  def like
  end

  def unlike
  end


  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
