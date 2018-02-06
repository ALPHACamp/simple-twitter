class AddTweetsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tweets_count, :integer, default: 0
    #新增tweets的counter cache
    User.pluck(:id).each do |i|
      User.reset_counters(i, :tweets)
      #全部重算一次
    end
  end
end
