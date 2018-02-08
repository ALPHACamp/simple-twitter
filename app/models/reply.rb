class Reply < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :tweet, class_name: "Tweet"
  #就是留言，留言的模型跟推特不一樣

  #counter_cache 計算關聯物件的數量
  belongs_to :tweet, counter_cache: true
end
