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
    @tweet=Tweet.find(params[:id])
    @like=@tweet.likes.create!(user: current_user) 

    @u_likes_count=current_user.likes.count
    @user_like=User.update(current_user.id,likes_count: @u_likes_count)
    @user_like.save

    @t_likes_count=@tweet.likes.count
    @tweet_like=Tweet.update(@tweet.id,likes_count: @t_likes_count)
    @tweet_like.save!    

    redirect_back(fallback_location: root_path)
  end

  def unlike
    @tweet=Tweet.find(params[:id])
    @tweet_l=Like.where(tweet_id: params[:id])

    @unlike=@tweet_l.where(user_id: current_user.id).each{|uk| uk.destroy}

    @likes_count=current_user.likes.count
    @user_like=User.update(current_user.id,likes_count: @likes_count)
    @user_like.save

    @t_likes_count=@tweet.likes.count
    @tweet_like=Tweet.update(@tweet.id,likes_count: @t_likes_count)
    @tweet_like.save!      
          
    redirect_back(fallback_location: root_path)    
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end
end
