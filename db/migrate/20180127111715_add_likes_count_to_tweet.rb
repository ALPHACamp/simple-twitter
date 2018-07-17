class AddLikesCountToTweet < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :likes_count, :integer, :default => 0

    Tweet.pluck(:id).each do |i|
      Tweet.reset_counters(i, :likes)
    end
  end
end
