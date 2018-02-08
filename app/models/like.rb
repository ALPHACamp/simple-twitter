class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: :tweet_id }
  belongs_to :user, optional: true
  belongs_to :tweet, optional: true
end
