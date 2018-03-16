class Reply < ApplicationRecord
  validates_presence_of :comment, on: :create, message: "Can't be blank"
  belongs_to :user
  belongs_to :tweet, counter_cache: true
  #就是留言，留言的模型跟推特不一樣

end
