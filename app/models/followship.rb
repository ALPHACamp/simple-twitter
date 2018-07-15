class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user
  #followers計算內建功能預設為model名稱改自訂欄位名followers_count
  belongs_to :following, class_name: "User", counter_cache: :followers_count


end
