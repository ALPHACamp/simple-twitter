class AddFollowshipsCountToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :followships_count, :integer
  end
end
