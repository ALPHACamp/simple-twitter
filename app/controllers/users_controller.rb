class UsersController < ApplicationController


before_action :set_user, only: [:tweets, :edit, :update, :likes, :followings, :followers]



  # def index
  #   @users = User.page(params[:page]).per(30).order('created_at DESC')
  #   @tweets= Tweet.page(params[:page]).per(30).order('created_at DESC')
  # end
  #
  # def show
  #   @commented_restaurants = @user.restaurants.uniq
  #   @favorited_restaurants = @user.restaurants
  #   @followings = @user.followings
  #   @followers = @user.followers
  # end



  def tweets
    @tweets = @user.tweets.page(params[:page]).per(10).order(created_at: :desc)
    @users = User.all
  end


  def edit
     unless @user == current_user
       redirect_to tweets_user_path(@user)
     end
   end


   def update

     if @user.update_attributes(user_params)
       redirect_to tweets_user_path(@user)
       flash[:notice] = "Profile was successfully updated"
     else
       render :edit
       flash[:alert] = "Profile was failed to update"
     end
   end


   def likes
     # @likes # 基於測試規格，必須講定變數名稱
     @likes = @user.tweets.joins(:likes).page(params[:page]).per(10).order("likes.created_at desc")
    #  @likes = @user.liked_tweets.page(params[:page]).per(10).order("likes.created_at DESC")
    # @likes = @user.likes.order(created_at: :desc)
    #@likes_tweet = @user.liked_tweets.order('likes.updated_at DESC')
   end


  def followings
    # @followings # 基於測試規格，必須講定變數名稱
    @followings = @user.followings.order('followships.created_at desc')

  end

  def followers
    # @followers # 基於測試規格，必須講定變數名稱
    @followers = @user.followers.order('followships.created_at desc')

  end





     private

     def set_user
        @user = User.find(params[:id])
     end

     def user_params
       params.require(:user).permit(:name, :introduction, :avatar)
     end



end
