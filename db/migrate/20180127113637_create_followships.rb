class CreateFollowships < ActiveRecord::Migration[5.1]
  def change
    create_table :followships do |t|
      t.integer :user_id
      t.integer :following_id
      t.timestamps
    end

    add_index :followships, [:user_id, :following_id]
  end
end
