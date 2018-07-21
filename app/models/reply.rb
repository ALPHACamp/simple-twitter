class Reply < ApplicationRecord
	belongs_to :user, counter_cache: :replies_count
	belongs_to :tweet, counter_cache: :replies_count
end
