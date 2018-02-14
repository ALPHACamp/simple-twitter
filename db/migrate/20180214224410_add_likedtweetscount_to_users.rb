class AddLikedtweetscountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :likedtweets_count, :integer
  end
end
