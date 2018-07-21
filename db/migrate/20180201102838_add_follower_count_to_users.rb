class AddFollowerCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :followers_count, :integer, default: 0
  end
end
