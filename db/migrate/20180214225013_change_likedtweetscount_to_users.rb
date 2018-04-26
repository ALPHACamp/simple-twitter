class ChangeLikedtweetscountToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :likedtweets_count, :integer, default: 0
  end
end
