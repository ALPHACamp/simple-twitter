class RemoveLikedtweetsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :likedtweets_count
  end
end
