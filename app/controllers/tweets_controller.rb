class TweetsController < ApplicationController

  def index
     # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users=User.order(followers_count: :desc).limit(10)
    @tweet=Tweet.new
    @tweets=Tweet.order("updated_at DESC")
  end

  def create

    @tweet=Tweet.new(tweet_params)
    @tweet.user=current_user
    if @tweet.save
      flash[:notice] = "留言成功"
      
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] =@tweet.errors.full_messages.each{|msg| msg.class}

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
