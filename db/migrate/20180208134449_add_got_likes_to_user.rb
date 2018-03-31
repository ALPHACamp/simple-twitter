class AddGotLikesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :got_likes_count, :integer, default: 0
  end
end
