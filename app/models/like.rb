class Like < ApplicationRecord
  belongs_to :tweets, counter_cache: true
  belongs_to :user, counter_cache: true
end
