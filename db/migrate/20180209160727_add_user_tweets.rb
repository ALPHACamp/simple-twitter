class AddUserTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :weets_count, :integer
  end
end
