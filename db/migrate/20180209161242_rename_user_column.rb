class RenameUserColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :weets_count, :tweets_count
  end
end
