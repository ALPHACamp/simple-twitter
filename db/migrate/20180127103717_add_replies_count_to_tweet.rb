class AddRepliesCountToTweet < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :replies_count, :integer, :default => 0

    Tweet.pluck(:id).each do |i|
      Tweet.reset_counters(i, :replies)
    end
  end
end
