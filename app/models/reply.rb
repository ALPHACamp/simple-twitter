class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, counter_cache: :replies_count
end
