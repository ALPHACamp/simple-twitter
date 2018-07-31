class AddTweetsCountToUsersAction < ActiveRecord::Migration[5.1]
  def change
    User.pluck(:id).each do |i|
      User.reset_counters(i, :tweets)
    end
  end
end
