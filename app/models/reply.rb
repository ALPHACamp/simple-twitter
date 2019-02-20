class Reply < ApplicationRecord

  belongs_to :tweet, counter_cache: true
  belongs_to :user
  
end
