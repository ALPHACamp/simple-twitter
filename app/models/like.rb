class Like < ApplicationRecord
	belongs_to :user, counter_cache: :likes_count
	belongs_to :tweet, counter_cache: :likes_count
end
