class TweetsController < ApplicationController
before_action :set_tweet, only: [:like, :unlike]
# :edit, :update, :destroy,

  def index
    @users = User.all.order(followers_count: :desc).limit(10) # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料


    @tweets = Tweet.new
    @tweets = Tweet.page(params[:page]).per(20).order(created_at: :desc)


  end



  def create
    @tweet = current_user.tweets.build(tweet_params)
       if @tweet.save
         redirect_to root_path
       else
         flash[:alert] = @tweet.errors.full_messages.to_sentence
         @tweets = Tweet.page(params[:page]).per(20).order(created_at: :desc)
         render :index
       end
  end


    #  def each(&block)
    #    @users.each(&block)
    #  end


  # def edit
  #    unless @user == current_user
  #      redirect_to tweets_user_path(@user)
  #    end
  #  end
  #
  # def update
  #
  #   @tweet.update(tweet_params)
  #   flash[:notice] = "tweet was updated"
  # end


  # def destroy
  #
  #   @tweet_id = params[:id]
  #   if @tweet.user == current_user
  #     @tweet.destroy
  #     redirect_to tweets_user_path(@user)
  #   end
  #   flash[:alert] = "tweet was deleted"
  # end



  def like

    @tweet.likes.create!(user: current_user)
    redirect_back(fallback_location: tweets_user_path)
  end

  def unlike

    like = Like.where(tweet: @tweet, user: current_user)
    like.destroy_all
    redirect_back(fallback_location: tweets_user_path)
  end






  private

  def set_tweet
     @tweet = Tweet.find(params[:id])
  end


  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
