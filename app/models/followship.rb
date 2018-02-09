class Followship < ApplicationRecord
  # 每個 User 只能追蹤另一個 User 一次
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :following, class_name: "User", counter_cache: :followers_count

  # counter_cache 可以自動回傳 size 方法結果，計算關聯物件的數量
  # 必須在關聯 Model 上加一個欄位，慣例命名為 {table_name}_count
  # 指南：https://rails.ruby.tw/association_basics.html
  # 打開 counter_cache 之後，也會啟動這些相關方法：http://api.rubyonrails.org/v5.0/classes/ActiveRecord/CounterCache/ClassMethods.html
  # 有了 counter_cache 之後，就不需要手工撰寫的方法了，可以回 Model 和 Controler 將之刪除

end
