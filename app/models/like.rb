class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  belongs_to :liking, class_name: "Tweet", foreign_key: "tweet_id"
end
