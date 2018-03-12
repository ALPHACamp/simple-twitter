class UpdateUserColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :liked_tweets_count, :integer
  end
end
