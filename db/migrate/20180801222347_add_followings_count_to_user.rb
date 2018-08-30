class AddFollowingsCountToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :followings_count, :integer, default: 0
  	
 
  end
end
