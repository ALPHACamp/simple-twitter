class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.text :description
      t.integer :user_id

      t.timestamps
    end

    add_index :tweets, :user_id
  end
end
