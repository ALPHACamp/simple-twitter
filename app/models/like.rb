class Like < ApplicationRecord

  belongs_to :tweet
  belongs_to :user, :counter_cache => true
  
end
