class Followship < ApplicationRecord
  # 因應 rspec 生成 followship instance 的方式，要把更新 followers_count 移到這邊執行
  after_commit :sync_followers_count

  # 使用者不能重複追蹤同樣的人
  validates :following_id, uniqueness: { scope: :user_id }

  # 追蹤記錄屬於使用者
  belongs_to :user, counter_cache: true

  # 追蹤記錄屬於被追蹤的人
  belongs_to :following, class_name: "User"

  def sync_followers_count
    # 先找到要更新 followers_count 的 user
    user = User.find(self.following_id)
    # 呼叫 寫在 user model 的 class method
    user.count_followers
  end
end
