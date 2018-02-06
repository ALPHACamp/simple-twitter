class TweetsController < ApplicationController
  before_action :set_tweet, only:  [:like, :unlike, :destroy, :update]

  def index
    @users = User.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @tweets = Tweet.order(created_at: :desc)

    @tweet = Tweet.new
  end

  def create    
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user

    if @tweet.save
      flash[:notice] = "Tweet was successfully created"
    else
      flash[:alert] = "Tweet was failed to create.  #{@tweet.errors.full_messages.to_sentence}"
    end
    redirect_to root_path
  end

  def update
    if @tweet.update(tweet_params)
      flash[:notice] = "Tweet was successfully updated."
    else
      flash[:alert] = "Tweet was failed to update. #{@tweet.errors.full_messages.to_sentence}"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @tweet.user == current_user 
      @tweet.destroy

      if @tweet.present?
        flash[:notice] = "Tweet was successfully deleted."
      else
        flash[:alert] = "Tweet does not exist."
      end
      redirect_to root_path
      
    else
      flash[:alert] = "You are not authorized."
      redirect_to root_path
    end
  end

  def like
    Like.create(tweet: @tweet, user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private 

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
