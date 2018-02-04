class Like < ApplicationRecord
  belongs_to :users, counter_cache: true
  belongs_to :tweets, counter_cache: true
end
