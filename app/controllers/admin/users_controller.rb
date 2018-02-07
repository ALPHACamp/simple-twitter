class Admin::UsersController < Admin::BaseController
  def index
    # 管理者可以瀏覽站內所有的使用者清單，該清單按推播文數排序
    # @users= User.joins(:tweet).merge(Tweet.order(created_at: :desc))
    # @users = User.joins(:user_extension).merge(UserExtension.order(company: :desc))
    # @users = User.includes(:tweets).order("tweet.created_at desc").page(params[:page]).per(10)
    @users = User.page(params[:page]).per(10)
  end
end
