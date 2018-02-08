class TweetsController < ApplicationController

  def index
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      flash[:notice] = "成功推播(tweet)"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @tweet.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def like
    @like = current_user.likes.build(tweet_id: params[:id])
    if @like.save
      flash[:notice] = "成功Like該則推播！"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @like.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def unlike
    @like = current_user.likes.where(tweet_id: params[:id]).first
    @like.destroy
    flash[:notice] = "成功Unlike該則推播！"
    redirect_back(fallback_location: root_path)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
