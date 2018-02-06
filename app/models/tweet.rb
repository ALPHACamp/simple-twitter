class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140, :message => "超過字數限制"

  # 設定關聯
  belongs_to :user
  has_many :replies 

end
