class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  # 設置tweet 與 user的多對一關係
  belongs_to :user

end
