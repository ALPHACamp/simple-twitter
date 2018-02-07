class Like < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :tweet, class_name: "Tweet"
  #如何知道被喜歡
end
