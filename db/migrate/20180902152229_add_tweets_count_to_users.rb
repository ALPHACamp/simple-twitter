class AddTweetsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    # 新增使用者的推播數欄位
    add_column :users, :tweets_count, :integer, :default => 0

    # 快速的撈出指定欄位的資料後重新計算
    User.pluck(:id).each do |i|
      User.reset_counters(i, :tweets)
    end

  end
end
