class Reply < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :tweet, class_name: "Tweet"
  #就是留言，留言的模型跟推特不一樣
end
