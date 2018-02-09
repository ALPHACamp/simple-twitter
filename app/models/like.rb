class Like < ApplicationRecord
  #default_scope { order(created_at: :desc) }
  
  belongs_to :tweet, counter_cache: true
  belongs_to :user, counter_cache: true
end
