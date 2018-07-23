class AddDefaultValueToTweetsCount < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :tweets_count, :integer, default: 0
  end
end
