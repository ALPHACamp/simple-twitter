class AddTweetCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tweets_count, :integer, default: 0
  end
end
