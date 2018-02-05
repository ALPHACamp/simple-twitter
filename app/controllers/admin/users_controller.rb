class Admin::UsersController < Admin::BaseController
  def index
    # 管理者可以瀏覽站內所有的使用者清單，該清單按推播文數排序
    @twiters = User.joins(:tweets).group("user_id").order("count(user_id) DESC")
  end
end
