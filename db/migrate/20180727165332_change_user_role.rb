class ChangeUserRole < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :role, :string, default: 'normal'
  	add_column :users,:role, :string
  end
end
