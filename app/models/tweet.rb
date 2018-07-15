class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140 #一個推播最多140個字

  belongs_to :user #一個推播屬於一個使用者
end
