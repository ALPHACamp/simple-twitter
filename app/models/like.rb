class Like < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :tweet, counter_cache: true
  validates :user, uniqueness: { scope: :tweet }
end
