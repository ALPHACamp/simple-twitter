class AddTweetcountsToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :tweets_count, :integer, :default => 0
  end
end
