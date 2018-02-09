class AddFollowshipsCountToFollowship < ActiveRecord::Migration[5.1]
  def change
    add_column :followships, :followships_count, :integer, default: 0
  end
end
