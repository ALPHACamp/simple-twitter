class Reply < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tweet, counter_cache: true
end
