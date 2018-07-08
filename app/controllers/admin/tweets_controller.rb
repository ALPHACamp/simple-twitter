class Admin::TweetsController < Admin::BaseController


  def index
    #把order(followers_count: :desc)放在 index page 這樣就能同步更新。當在首頁按下follow的時候。
    @users = User.limit(10)# 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料

    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)

    # 加此方法是為了在主頁能同步更新 follower_count = followers. 照前章節來做 會變成只有回到users follower 的頁面再回到主頁 才會更新
    @users.each do |user|
      user.followers_count = user.followers.size
      user.save
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_root_path
    flash[:alert] = "tweet was deleted"
  end
end
