class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
    @users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料  
  end

 



  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      #flash 會留到下一個request
      flash[:notice] = "tweets was scuccessfully created"
      redirect_to root_path
    else
      #flash.now 只存在現在這個request
      flash.now[:alert] = "tweets was failed to create" 
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
