class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, count_cache: true
end
