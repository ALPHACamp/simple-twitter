class AddFollowshipsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :followships_count, :integer, default: 0
  end
end
