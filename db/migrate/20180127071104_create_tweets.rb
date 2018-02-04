class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.text :description
      t.integer :user_id, :repiles_count, :likes_count

      t.timestamps
    end

    add_index :tweets, :user_id
  end
end
