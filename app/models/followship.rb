class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  belongs_to :user
  # counter_cache 可以自動回傳 size 方法結果，計算關聯物件的數量
  # 必須在關聯 Model 上加一個欄位，慣例命名為 {table_name}_count
  # 將counter指定給user的欄位followers_count
  belongs_to :following, class_name: "User", counter_cache: :followers_count
end
