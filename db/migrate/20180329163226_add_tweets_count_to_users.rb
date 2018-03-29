class AddTweetsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tweets_count, :intger, default: 0
  end
end
