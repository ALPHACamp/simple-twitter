class AddLikesCountOnUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :likes_count, :integer, :default => 0

    User.pluck(:id).each do |i|
      User.reset_counters(i, :likes)
    end
  end
end
