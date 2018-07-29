class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.text :description
      t.integer :user_id
      t.integer :replies_count
      t.integer :likes_count
      t.timestamps
    end
  end
end
