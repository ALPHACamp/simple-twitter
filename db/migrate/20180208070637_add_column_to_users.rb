class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :followings_count, :integer, default: 0
    add_column :users, :replies_count, :integer, default: 0
    add_column :users, :liked_tweets_count, :integer, default: 0
    add_column :users, :replied_tweets_count, :integer, default: 0

  end
end
