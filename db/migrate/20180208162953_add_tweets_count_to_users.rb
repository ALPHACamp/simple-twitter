class AddTweetsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :tweets_count
  end
end
