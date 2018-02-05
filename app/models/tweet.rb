class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140,:message => "超過140個字"
  belongs_to :user
  #tweet只能有一個作者

  has_many :replies, dependent: :destroy
  #刪掉tweet 就會刪掉reply

  has_many :likes, dependent: :destroy
  #刪掉tweet 就會刪掉like
end


      