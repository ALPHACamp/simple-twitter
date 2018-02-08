class AddTweetsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tweets_count, :integer, :default => 0

    User.find_each do |user|
      user.tweets_count = user.tweets.size
      user.save!
    end
  end
end
