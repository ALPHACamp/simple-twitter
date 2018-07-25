class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  #tweet只有一個作者

end
