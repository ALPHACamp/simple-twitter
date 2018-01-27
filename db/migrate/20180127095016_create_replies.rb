class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.text :comment
      t.integer :tweet_id
      t.integer :user_id

      t.timestamps
    end

    add_index :replies, [:tweet_id, :user_id]
  end
end
