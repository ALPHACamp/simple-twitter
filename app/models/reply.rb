class Reply < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"}
  belongs_to :tweet, class_name: "Tweet", foreign_key: "tweet_id"}
  #就是留言，留言的模型跟推特不一樣
end
