class Admin::UsersController < Admin::BaseController
  def index
    #11.3管理者可以瀏覽站內所有的使用者清單
    #11.3.1該清單會列出他們的活躍程度（包括推播數量、關注人數、跟隨者人數、like 過的推播數）
    #12.管理者可以瀏覽站內所有的使用者清單，該清單按推播文數排序
  end
end
