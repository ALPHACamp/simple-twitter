class AddTweetsCountFollowingsCountToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tweets_count, :integer, default: 0
    add_column :users, :followings_count, :integer, default: 0
  end
end
