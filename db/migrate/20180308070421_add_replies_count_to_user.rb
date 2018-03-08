class AddRepliesCountToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :replies_count, :integer, default: 0
  end
end
