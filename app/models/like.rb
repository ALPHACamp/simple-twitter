class Like < ApplicationRecord
  belongs_to :user, counter_cache: true, optional: true
  belongs_to :tweet, counter_cache: true, optional: true  
end
